:-use_module(library(lists)), use_module(library(random)).
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

test_board_board([[[[block,block,block,player2_1,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,player2_1,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,player2_1,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,player2_1,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,player2_1,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,player2_1,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,player2_1,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,empty,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,player2_1,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]]],[[[block,block,block,player2_3,player2_1,player2_2,block,block,block],[block,block,block,empty,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,empty,player2_3,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,empty,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,player2_3,player1_1,player1_2,block,block,block]]],[[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,player2_4,empty,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]]],[[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,empty,player2_5,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]]],[[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,player2_6,empty,block,block,block],[empty,empty,empty,player2_7,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]]],[[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[player2_7,empty,empty,empty,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,player2_7,empty,empty,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,player2_7,empty,empty,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,empty,player2_7,player2_8,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,empty,empty,player2_8,player2_7,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,empty,empty,player2_8,empty,player2_7,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,empty,empty,player2_8,empty,empty,player2_7],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,empty,empty,player2_8,empty,empty,empty],[empty,empty,empty,player2_7,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]]],[[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[player2_8,empty,empty,player2_7,empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,player2_8,empty,player2_7,empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,player2_8,player2_7,empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,player2_8,empty,empty,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,empty,player2_8,empty,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,empty,empty,player2_8,empty],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,empty,empty,empty,player2_8],[empty,empty,empty,empty,empty,empty,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]],[[block,block,block,empty,player2_1,player2_2,block,block,block],[block,block,block,player2_3,empty,player2_4,block,block,block],[block,block,block,player2_5,empty,player2_6,block,block,block],[empty,empty,empty,player2_7,empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty,player2_8,empty,empty,empty],[empty,empty,empty,player1_7,empty,player1_8,empty,empty,empty],[block,block,block,player1_5,empty,player1_6,block,block,block],[block,block,block,player1_3,empty,player1_4,block,block,block],[block,block,block,empty,player1_1,player1_2,block,block,block]]]]).

player(player1).
player(player2).

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

move_marble(Player, Marble, Board, Line-Column, NewBoard):-     atom_string(Player, PlayerString),
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



get_all_moves_from_all_pos(Board, [], []).
get_all_moves_from_all_pos(Board, [L-C|Rest], Moves):-  get_all_moves_from_pos(Board, L-C, M1), 
                                                        get_all_moves_from_all_pos(Board, Rest, M2), 
                                                        append([M1], M2, Moves).

choose_from_list([], _, []).
choose_from_list([A|Rest], 0, A).
choose_from_list([A|Rest], X, RetList):- length(Rest, S), Size is S+1, X<Size, X>0, X1 is X-1, choose_from_list(Rest, X1, RetList).

best_move_ai(0, Board, Player, Marble, LineMove-ColumnMove):-   marbles(Player, MarblesNames),
                                                                get_all_positions(Board, MarblesNames, Positions),
                                                                get_all_moves_from_all_pos(Board, Positions, Moves),
                                                                length(Moves, LP1),
                                                                LenPos is LP1-1,
                                                                random(0, LenPos, N1),
                                                                choose_from_list(Moves, N1, Ins),
                                                                length(Ins, LP2),
                                                                LenIns is LP2-1,
                                                                (       LenIns =:= 0 ->
                                                                                N2 = 0
                                                                ;       otherwise ->
                                                                                random(0, LenIns, N2)
                                                                ),
                                                                choose_from_list(Ins, N2, LineMove-ColumnMove),
                                                                choose_from_list(MarblesNames, N1, Marble).


movesSum([], 0).
movesSum([A|Rest], Score) :- movesSum(Rest, S1), length(A, M), Score is S1+M.

evaluationScore(Board, Player, Score):- marbles(Player, MarblesPlayer),
                                        get_all_positions(Board, MarblesPlayer, PositionsPlayer),
                                        get_all_moves_from_all_pos(Board, PositionsPlayer, MovesPlayer),
                                        movesSum(MovesPlayer, S1),
                                        next_player(Player, Opponent),
                                        marbles(Opponent, MarblesOpponent),
                                        get_all_positions(Board, MarblesOpponent, PositionsOpponent),
                                        get_all_moves_from_all_pos(Board, PositionsOpponent, MovesOpponent),
                                        movesSum(MovesOpponent, S2),
                                        Score is S1-S2.

all_boards_aux(_, _, _, [], []).
all_boards_aux(Board, Player, Marble, [L-C|RestListOfMoves], NewBoards):- findIndexesBoard(Board, Marble, L_ini-C_ini), 
                                                                          insert_in_board(Board, Marble, L, C, NB1), 
                                                                          insert_in_board(NB1, empty, L_ini, C_ini, NewBoard),
                                                                          all_boards_aux(Board, Player, Marble, RestListOfMoves, Res),
                                                                          append([NewBoard], Res, NewBoards).

all_boards(_, _, _, [], []).
all_boards(Board, Player, [FirstMarble|RestMarbles], [First|RestMoves], NewBoards):- all_boards_aux(Board, Player, FirstMarble, First, Res), 
                                                                                     all_boards(Board, Player, RestMarbles, RestMoves, Res2),
                                                                                     append([Res], Res2, NewBoards).

allEvaluationScore([], Player, []).
allEvaluationScore([A|Rest], Player, Scores):- evaluationScore(A, Player, S1), allEvaluationScore(Rest, Player, S2), append([S1], S2, Scores).

sublistBestEvaluationScore([], Player, [], []).
sublistBestEvaluationScore([[]|Rest], Player, Scores, Is):- sublistBestEvaluationScore(Rest, Player, Scores, Is).
sublistBestEvaluationScore([A|Rest], Player, Scores, Is):- allEvaluationScore(A, Player, S1), max_list(S1, M, I), sublistBestEvaluationScore(Rest, Player, S2, Is1), append([M], S2, Scores), append([I], Is1, Is).

depthMinimaxCalls([], _, _, _, [], []).

depthMinimaxCalls([A|Rest], Player, Depth, 1, MLCs, Scores):-   minimax(A, Player, Depth, 1, M, LM-CM, S1),
                                                                depthMinimaxCalls(Rest, Player, Depth, 1, TmpMLCs, TmpScores),
                                                                append([M-LM-CM], TmpMLCs, MLCs),
                                                                append([S1], TmpScores, Scores).

depthMinimaxCalls([A|Rest], Player, Depth, 0, MLCs, Scores):-   minimax(A, Player, Depth, 0, M, LM-CM, S1),
                                                                depthMinimaxCalls(Rest, Player, Depth, 0, TmpMLCs, TmpScores),
                                                                append([M-LM-CM], TmpMLCs, MLCs),
                                                                append([S1], TmpScores, Scores).

sublistDepthMinimaxCalls([], _, _, _, [], []).
sublistDepthMinimaxCalls([A|Rest], Player, Depth, 1, MLCs, Scores):-    depthMinimaxCalls(A, Player, Depth, 1, MLCs1, Scores1),
                                                                        max_list(Scores1, S1, I1),
                                                                        nth0(I1, MLCs1, MLC1),
                                                                        sublistDepthMinimaxCalls(Rest, Player, Depth, 1, MLCs2, Scores2),
                                                                        append([S1], Scores2, Scores),
                                                                        append([MLC1], MLCs2, MLCs).
sublistDepthMinimaxCalls([A|Rest], Player, Depth, 0, MLCs, Scores):-    depthMinimaxCalls(A, Player, Depth, 0, MLCs1, Scores1),
                                                                        min_list(Scores1, S1, I1),
                                                                        nth0(I1, MLCs1, MLC1),
                                                                        sublistDepthMinimaxCalls(Rest, Player, Depth, 0, MLCs2, Scores2),
                                                                        append([S1], Scores2, Scores),
                                                                        append([MLC1], MLCs2, MLCs).


minimax(Board, Player, 0, 1, Marble, LineMove-ColumnMove, Score):-      write('loop11'), marbles(Player, MarblesPlayer),
                                                                        write('loop12'), get_all_positions(Board, MarblesPlayer, PositionsPlayer),
                                                                        write('loop13'), get_all_moves_from_all_pos(Board, PositionsPlayer, MovesPlayer),
                                                                        write('loop14'), all_boards(Board, Player, MarblesPlayer, MovesPlayer, NewBoards),
                                                                        write('loop15'), sublistBestEvaluationScore(NewBoards, Player, TmpScores, Is),
                                                                        write('loop16'), max_list(TmpScores, Score, I),
                                                                        write('loop17'), nth0(I, MarblesPlayer, Marble),
                                                                        write('loop18'), nth0(I, Is, TmpI),
                                                                        write('loop19'), nth0(I, MovesPlayer, TmpMoves),
                                                                        write('loop10'), nth0(TmpI, TmpMoves, LineMove-ColumnMove).


minimax(Board, Player, 0, 0, Marble, LineMove-ColumnMove, Score):-      write('loop21'), next_player(Player, OpponentPlayer),
                                                                        write('loop22'), marbles(OpponentPlayer, MarblesOpponentPlayer),
                                                                        write('loop23'), get_all_positions(Board, MarblesOpponentPlayer, PositionsOpponentPlayer),
                                                                        write('loop24'), get_all_moves_from_all_pos(Board, PositionsOpponentPlayer, MovesOpponentPlayer),
                                                                        write('loop25'), all_boards(Board, OpponentPlayer, MarblesOpponentPlayer, MovesOpponentPlayer, NewBoards),
                                                                        write('loop26'), sublistBestEvaluationScore(NewBoards, Player, TmpScores, Is),
                                                                        write('loop27'), min_list(TmpScores, Score, I),
                                                                        write('loop28'), nth0(I, MarblesOpponentPlayer, Marble),
                                                                        write('loop29'), nth0(I, Is, TmpI),
                                                                        write('loop20'), nth0(I, MovesOpponentPlayer, TmpMoves),
                                                                        write('loop2a'), nth0(TmpI, TmpMoves, LineMove-ColumnMove). 


minimax(Board, Player, Depth, 0, Marble, LineMove-ColumnMove, Score):-  write('loop3'), write(' '), write(Depth), write('\n'), marbles(Player, MarblesPlayer),
                                                                        get_all_positions(Board, MarblesPlayer, PositionsPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsPlayer, MovesPlayer),
                                                                        all_boards(Board, Player, MarblesPlayer, MovesPlayer, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 1, MLCs, Scores),
                                                                        max_list(Scores, Score, I),
                                                                        nth0(I, MLCs, Marble-LineMove-ColumnMove).

minimax(Board, Player, Depth, 1, Marble, LineMove-ColumnMove, Score):-  write('loop4'), write(' '), write(Depth), write('\n'), next_player(Player, OpponentPlayer),
                                                                        marbles(OpponentPlayer, MarblesOpponentPlayer),
                                                                        get_all_positions(Board, MarblesOpponentPlayer, PositionsOpponentPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsOpponentPlayer, MovesOpponentPlayer),
                                                                        all_boards(Board, OpponentPlayer, MarblesOpponentPlayer, MovesOpponentPlayer, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 0, MLCs, Scores),
                                                                        min_list(Scores, Score, I),
                                                                        nth0(I, MLCs, Marble-LineMove-ColumnMove).


best_move_ai(1, Board, Player, Marble, LineMove-ColumnMove):- minimax(Board, Player, 3, 0, Marble, LineMove-ColumnMove, _).