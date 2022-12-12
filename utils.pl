findIndexLine([Target|_], Target, 0):- !.
findIndexLine([_|Tail], Target, Column):- findIndexLine(Tail, Target, Res),
                                          !,
                                          Column is Res+1.

findIndexesBoard([Line|_], Target, 0-ColumnN):- findIndexLine(Line, Target, ColumnN).
findIndexesBoard([_|Tail], Target, LineN-ColumnN):- findIndexesBoard(Tail, Target, Res-ColumnN),
                                                    LineN is Res+1.


read_number(Number):- get_code(Code),
                      Number is Code-48.