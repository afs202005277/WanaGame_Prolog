:-use_module(library(lists)).
:- ['io.pl', 'utils.pl'].
start_board([[block, block, block, player2_1, empty, player2_2, block, block, block],
        [block, block, block, player2_3, empty, player2_4, block, block, block],
        [block, block, block, player2_5, empty, player2_6, block, block, block],
        [empty, empty, empty, player2_7, empty, player2_8, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, player1_7, empty, player1_8, empty, empty, empty],
        [block, block, block, player1_5, empty, player1_6, block, block, block],
        [block, block, block, player1_3, empty, player1_4, block, block, block],
        [block, block, block, player1_1, empty, player1_2, block, block, block]]).

player(player1).
player(player2).

next_player(player1, player2).
next_player(player2, player1).

valid_move_down(_, X-Y, X-Y).
valid_move_up(_, X-Y, X-Y).
valid_move_left(_, X-Y, X-Y).
valid_move_right(_, X-Y, X-Y).

valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                        nth0(Cidx_f, Line, empty),
                                                        NewY is (Cidx_f-1) mod 9,
                                                        valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, empty),
                                                  NewY is (Cidx_f+1) mod 9,
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is (Lidx_f+1) mod 9,
                                                  valid_move_up(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is (Lidx_f-1) mod 9,
                                                  valid_move_down(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i);
                                                  valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f);
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f).

marble_naming(Player, Marble, Board, Res) :-    append("_", Marble, Suffix),
                                                append(Player, Suffix, Target),
                                                maplist(char_code, X, Target),
                                                atom_chars(Res, X).

get_all_moves(Board, Lidx_i-Cidx_i, Moves):- findall(L-C, (start_board(Board), valid_move(Board, 3-3, L-C)), Res), 
                                             remove_dups(Res, Deduplicated),
                                             list_del(Deduplicated, Lidx_i-Cidx_i, Moves).
get_marble_position(Player, Marble, Board, Line-Column):- marble_naming(Player, Marble, Board, Res),
                                                          findIndexesBoard(Board, Res, Line-Column).

move_marble(Player, Marble, Board, Line-Column, NewBoard):-     get_marble_position(Player, Marble, Board, L-C),
                                                                valid_move(Board, L-C, Line-Column),
                                                                marble_naming(Player, Marble, Board, Res),
                                                                insert_in_board(Board, Res, Line, Column, NB1),
                                                                insert_in_board(Board, 'empty', L, C, NewBoard).

play_game:- start_board(Board),
            player(Player),
            print_board(Board),
            game_cycle(Board-Player).

game_cycle(Board-Player):- game_over(Board, Winner), !,
                           congratulate(Winner).

game_cycle(Board-Player):- retrieve_command(Marble, Line-Column),
                           move_marble(Board, Move, NewBoard),
                           next_player(Player, NextPlayer),
                           print_board(Board-NextPlayer), !,
                           game_cycle(NewBoard-NextPlayer).
