:-use_module(library(lists)).
:-use_module(library(between)).

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

test_board([[block, block, block, player2_1, empty, player2_2, block, block, block],
        [block, block, block, player2_3, empty, player2_4, block, block, block],
        [block, block, block, player2_5, empty, player2_6, block, block, block],
        [empty, empty, empty, player2_7, empty, player2_8, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, player1_7, empty, player1_8, empty, empty, empty],
        [block, block, block, player1_5, empty, player1_6, block, block, block],
        [block, block, block, player1_3, block, player1_4, block, block, block],
        [block, block, block, player1_1, empty, player1_2, block, block, block]]).

player(player1).
player(player2).
size(9).

marbles(player1, [player1_1, player1_2, player1_3, player1_4, player1_5, player1_6, player1_7, player1_8]).
marbles(player2, [player2_1, player2_2, player2_3, player2_4, player2_5, player2_6, player2_7, player2_8]).

next_player(player1, player2).
next_player(player2, player1).


valid_move_left(_, X-Y, X-Y).
valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                        nth0(Cidx_f, Line, empty),
                                                        NewY is (Cidx_f-1) mod 9,
                                                        valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move_right(_, X-Y, X-Y).
valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, empty),
                                                  NewY is (Cidx_f+1) mod 9,
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move_up(_, X-Y, X-Y).
valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is (Lidx_f+1) mod 9,
                                                  valid_move_up(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move_down(_, X-Y, X-Y).
valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is (Lidx_f-1) mod 9,
                                                  valid_move_down(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i);
                                                  valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f);
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f).

marble_naming(Player, Marble, Res) :- append("_", Marble, Suffix),
                                      append(Player, Suffix, Target),
                                      atom_string(Res, Target).

get_all_moves_from_pos(Board, Lidx_i-Cidx_i, Moves):- findall(L-C, valid_move(Board, Lidx_i-Cidx_i, L-C), Res), 
                                             remove_dups(Res, Deduplicated),
                                             list_del(Deduplicated, Lidx_i-Cidx_i, Moves).

get_marble_position(Player, Marble, Board, Line-Column):- marble_naming(Player, Marble, Res),
                                                          findIndexesBoard(Board, Res, Line-Column).

move_marble(Player, Marble, Board, Line-Column, NewBoard):- atom_string(Player, PlayerString),
                                                                        atom_string_number(Marble, MarbleString),
                                                                        get_marble_position(PlayerString, MarbleString, Board, L-C),
                                                                        valid_move(Board, L-C, Line-Column),
                                                                        marble_naming(PlayerString, MarbleString, Res),
                                                                        insert_in_board(Board, Res, Line, Column, NB1),
                                                                        insert_in_board(NB1, empty, L, C, NewBoard).

get_all_positions(_, [], []).
get_all_positions(Board, [FirstMarble|Rest], Positions):- findIndexesBoard(Board, FirstMarble, L-C),
                                                          get_all_positions(Board, Rest, Res),
                                                          append([L-C], Res, Positions).

check_all_moves(_, []).
check_all_moves(Board, [L-C|Tail]):- get_all_moves_from_pos(Board, L-C, Res),
                                     \+length(Res, 0),
                                     check_all_moves(Board, Tail).

game_over(Board, Player):- marbles(Player, MarblesNames),
                           get_all_positions(Board, MarblesNames, Positions),
                           \+check_all_moves(Board, Positions).

play_game:- start_board(Board),
            player(Player),
            print_board(Board),
            game_cycle(Board-Player).

game_cycle(Board-Player):- game_over(Board, Player), !,
                           next_player(Player, NextPlayer),
                           congratulate(NextPlayer).

game_cycle(Board-Player):- retrieve_command(Player, Marble, Line-Column),
                           move_marble(Player, Marble, Board, Line-Column, NewBoard),
                           next_player(Player, NextPlayer),
                           print_board(NewBoard),
                           game_cycle(NewBoard-NextPlayer).
