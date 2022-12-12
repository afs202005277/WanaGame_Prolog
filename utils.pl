findIndexLine([Target|_], Target, 0):- !.
findIndexLine([_|Tail], Target, Column):- findIndexLine(Tail, Target, Res),
                                          !,
                                          Column is Res+1.

findIndexesBoard([Line|_], Target, 0-ColumnN):- findIndexLine(Line, Target, ColumnN).
findIndexesBoard([_|Tail], Target, LineN-ColumnN):- findIndexesBoard(Tail, Target, Res-ColumnN),
                                                    LineN is Res+1.


read_number(Number):- get_code(Code),
                      Number is Code-48.

list_slice([Head|Rest], 0, [Head], Rest).
list_slice([Head|Rest], X, Prefix, Suffix) :- X1 is X-1, list_slice(Rest, X1, Res, Suffix), append([Head], Res, Prefix).



insert_in_board(Board, Val, 0, 0, NewBoard) :-  nth0(0, Board, BoardLine, BoardWithoutLine),
                                                nth0(0, BoardLine, _, LineWithoutVal),
                                                append([Val], LineWithoutVal, NewLine),
                                                append(NewLine, BoardWithoutLine, NewBoard).
insert_in_board(Board, Val, X, 0, NewBoard) :-  X < 9,
                                                nth0(X, Board, BoardLine, BoardWithoutLine),
                                                nth0(Y, BoardLine, _, LineWithoutVal),
                                                X1 is X-1,
                                                list_slice(LineWithoutVal, X1, PrevLine, AfterLine),
                                                append(PrevLine, [Val], Tmp1),
                                                append(Tmp1, AfterLine, NewLine),
                                                append(NewLine, BoardWithoutLine, NewBoard).
insert_in_board(Board, Val, X, 0, NewBoard) :-  Y < 9,
                                                nth0(X, Board, BoardLine, BoardWithoutLine),
                                                nth0(Y, BoardLine, _, LineWithoutVal),
                                                append([Val], LineWithoutVal, NewLine),
                                                Y1 is Y-1,
                                                list_slice(BoardWithoutLine, Y1, PrevBoard, AfterBoard),
                                                append(PrevBoard, [NewLine], Tmp2),
                                                append(Tmp2, AfterBoard, NewBoard).
insert_in_board(Board, Val, X, Y, NewBoard) :-  X < 9,
                                                Y < 9,
                                                nth0(X, Board, BoardLine, BoardWithoutLine),
                                                nth0(Y, BoardLine, _, LineWithoutVal),
                                                X1 is X-1,
                                                list_slice(LineWithoutVal, X1, PrevLine, AfterLine),
                                                append(PrevLine, [Val], Tmp1),
                                                append(Tmp1, AfterLine, NewLine),
                                                Y1 is Y-1,
                                                list_slice(BoardWithoutLine, Y1, PrevBoard, AfterBoard),
                                                append(PrevBoard, [NewLine], Tmp2),
                                                append(Tmp2, AfterBoard, NewBoard).