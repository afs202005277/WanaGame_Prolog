findIndexLine([Target|_], Target, 0):- !.
findIndexLine([_|Tail], Target, Column):- findIndexLine(Tail, Target, Res),
                                          !,
                                          Column is Res+1.

findIndexesBoard([Line|_], Target, 0-ColumnN):- findIndexLine(Line, Target, ColumnN).
findIndexesBoard([_|Tail], Target, LineN-ColumnN):- findIndexesBoard(Tail, Target, Res-ColumnN),
                                                    LineN is Res+1.

read_number(Number):- get_code(Code),
                      Number is Code-48.

list_del(List, Elem, Res):- append(X, [Elem|Y], List),
                            append(X, Y, Res).
list_slice([Head|Rest], 0, [Head], Rest).
list_slice([Head|Rest], X, Prefix, Suffix) :- X1 is X-1, list_slice(Rest, X1, Res, Suffix), append([Head], Res, Prefix).



insert_in_board(Board, Val, 0, 0, NewBoard) :-  nth0(0, Board, BoardLine, BoardWithoutLine),
                                                nth0(0, BoardLine, _, LineWithoutVal),
                                                append([Val], LineWithoutVal, NewLine),
                                                append(NewLine, BoardWithoutLine, NewBoard).
insert_in_board(Board, Val, X, 0, NewBoard) :-  X < 9,
                                                nth0(X, Board, BoardLine, BoardWithoutLine),
                                                nth0(0, BoardLine, _, LineWithoutVal),
                                                append([Val], LineWithoutVal, NewLine),
                                                X1 is X-1,
                                                list_slice(BoardWithoutLine, X1, PrevBoard, AfterBoard),
                                                append(PrevBoard, [NewLine], Tmp2),
                                                append(Tmp2, AfterBoard, NewBoard).
insert_in_board(Board, Val, 0, Y, NewBoard) :-  Y < 9,
                                                nth0(0, Board, BoardLine, BoardWithoutLine),
                                                nth0(Y, BoardLine, _, LineWithoutVal),
                                                Y1 is Y-1,
                                                list_slice(LineWithoutVal, Y1, PrevLine, AfterLine),
                                                append(PrevLine, [Val], Tmp1),
                                                append(Tmp1, AfterLine, NewLine),
                                                append([NewLine], BoardWithoutLine, NewBoard).
insert_in_board(Board, Val, X, Y, NewBoard) :-  X < 9,
                                                Y < 9,
                                                nth0(X, Board, BoardLine, BoardWithoutLine),
                                                nth0(Y, BoardLine, _, LineWithoutVal),
                                                Y1 is Y-1,
                                                list_slice(LineWithoutVal, Y1, PrevLine, AfterLine),
                                                append(PrevLine, [Val], Tmp1),
                                                append(Tmp1, AfterLine, NewLine),
                                                X1 is X-1,
                                                list_slice(BoardWithoutLine, X1, PrevBoard, AfterBoard),
                                                append(PrevBoard, [NewLine], Tmp2),
                                                append(Tmp2, AfterBoard, NewBoard).

atom_string_number(Number, String):- Number >= 0,
                              Number < 10,
                              Code is Number+48,
                              append([], [Code], String).

atom_string(Atom, String):- maplist(char_code, Target, String),
                            atom_chars(Atom, Target).

atom_string(Atom, String):- atom_chars(Atom, Res),
                            maplist(char_code, Res, String).

max_list(L, M, I) :- nth0(I, L, M), \+ (member(E, L), E > M).
min_list(L, M, I) :- nth0(I, L, M), \+ (member(E, L), E < M).

del_all(_, [], []).
del_all(Elem, [Elem|T1], List2):-del_all(Elem, T1, List2).
del_all(Elem, [H1|T1], List2):-Elem\==H1,
                               del_all(Elem, T1, Res),
                               append([H1], Res, List2).

marble_naming(Player, Marble, Res) :- append("_", Marble, Suffix),
                                      append(Player, Suffix, Target),
                                      atom_string(Res, Target).

clear_input:-peek_char('\n'), get_char(_), !.
clear_input:- get_code(_),
              clear_input.