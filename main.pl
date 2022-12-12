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

% X -> colunas, Y -> linhas
valid_move(_, X-Y, X-Y).
valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- Cidx_f > Cidx_i,
                                                  nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, empty),
                                                  NewY is Cidx_f-1,
                                                  valid_move(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- Cidx_f < Cidx_i,
                                                  nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, empty),
                                                  NewY is Cidx_f+1,
                                                  valid_move(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- Lidx_f < Lidx_i,
                                                  nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is Lidx_f+1,
                                                  valid_move(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- Lidx_f > Lidx_i,
                                                  nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is Lidx_f-1,
                                                  valid_move(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

get_marble_position(Player, Marble, Board, Line-Column):- append("_", Marble, Suffix),
                                                          append(Player, Suffix, Target),
                                                          maplist(char_code, Res,Target),
                                                          atom_chars(X, Res),
                                                          findIndexesBoard(Board, X, Line-Column).



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