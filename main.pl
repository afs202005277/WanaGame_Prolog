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

% X -> colunas, Y -> linhas
valid_move(_, X-Y, X-Y):- !.
valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- Cidx_f > Cidx_i,
                                                  nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, 'empty'),
                                                  NewY is Cidx_f-1,
                                                  valid_move(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- Cidx_f < Cidx_i,
                                                  nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, 'empty'),
                                                  NewY is Cidx_f+1,
                                                  valid_move(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- Lidx_f < Lidx_i,
                                                  nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, 'empty'),
                                                  NewX is Lidx_f+1,
                                                  valid_move(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- Lidx_f > Lidx_i,
                                                  nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, 'empty'),
                                                  NewX is Lidx_f-1,
                                                  valid_move(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

marble_naming(Player, Marble, Board, Res) :-    append("_", Marble, Suffix),
                                                append(Player, Suffix, Target),
                                                maplist(char_code, X, Target),
                                                atom_chars(Res, X).

get_marble_position(Player, Marble, Board, Line-Column):- marble_naming(Player, Marble, Board, Res),
                                                          findIndexesBoard(Board, Res, Line-Column).

move_marble(Player, Marble, Board, Line-Column, NewBoard):-     get_marble_position(Player, Marble, Board, L-C),
                                                                valid_move(Board, L-C, Line-Column),
                                                                nth0(Line, Board, BoardLine, BoardWithoutLine),
                                                                nth0(Column, BoardLine, _, LineWithoutVal),
                                                                marble_naming(Player, Marble, Board, Res),
                                                                NewBoard is [Prev, Res, Post],
                                                                nth0(L, NewBoard, BoardLine),
                                                                nth0(C, BoardLine, _, [Prev, Post]),
                                                                NewBoard is [Prev, 'empty', Post].
                                        