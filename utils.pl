% findIndexLine(+Line:list(atom), +Element:atom, -Column:integer) 
% Auxiliary function used by findIndexesBoard to find the index of a value inside an array (line)
findIndexLine([Target|_], Target, 0):- !.
findIndexLine([_|Tail], Target, Column):- findIndexLine(Tail, Target, Res),
                                          !,
                                          Column is Res+1.

% findIndexesBoard(+Board:list(list(atom)), +Element:atom, -Coordinates:pair(Integer)) 
% Auxiliary function used to find the coordinates of a Element inside a Board
findIndexesBoard([Line|_], Target, 0-ColumnN):- findIndexLine(Line, Target, ColumnN).
findIndexesBoard([_|Tail], Target, LineN-ColumnN):- findIndexesBoard(Tail, Target, Res-ColumnN),
                                                    LineN is Res+1.

% findIndexesBoard(-Number:Integer) 
% Function that converts user input (ASCII format) to its numerical value
read_number(Number):- get_code(Code),
                      Number is Code-48.

% list_del(+List, +Elem, -Res:list)
% Auxiliary function that deletes an Elem from a given list
list_del(List, Elem, Res):- append(X, [Elem|Y], List),
                            append(X, Y, Res).

% list_slice(+List:list, +Index:integer, -Prefix:list, -Suffix:list)
% Auxiliary function that slices a list on a given index
list_slice([Head|Rest], 0, [Head], Rest).
list_slice([Head|Rest], X, Prefix, Suffix) :- X1 is X-1, list_slice(Rest, X1, Res, Suffix), append([Head], Res, Prefix).

% insert_in_board(+Board:list(list(atom)), +Val:atom, +X:integer, +Y:integer, -NewBoard:list(list(atom)))
% Auxiliary function that places the value 'Val' on the given coordinates in the Board
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

% atom_string_number(+Number:integer, -String:String)
% Auxiliary function that converts an integer to it's ASCII format
atom_string_number(Number, String):- Number >= 0,
                              Number < 10,
                              Code is Number+48,
                              append([], [Code], String).


% atom_string_number(+Atom:atom, -String:String)
% Auxiliary function that converts an atom to it's string counterpart and vice-versa
atom_string(Atom, String):- maplist(char_code, Target, String),
                            atom_chars(Atom, Target).

atom_string(Atom, String):- atom_chars(Atom, Res),
                            maplist(char_code, Res, String).

% max_list(+L:list, -M:element, -I:integer)
% Auxiliary function that gets the maximum element in a list and returns it in M and I
max_list(L, M, I) :- nth0(I, L, M), \+ (member(E, L), E > M).

% min_list(+L:list, -M:element, -I:integer)
% Auxiliary function that gets the minimum element in a list and returns it in M and I
min_list(L, M, I) :- nth0(I, L, M), \+ (member(E, L), E < M).

% min_list(+L:list, -M:element, -I:integer)
% Auxiliary function that gets the minimum element in a list and returns it in M and I
del_all(_, [], []).
del_all(Elem, [Elem|T1], List2):-del_all(Elem, T1, List2).
del_all(Elem, [H1|T1], List2):-Elem\==H1,
                               del_all(Elem, T1, Res),
                               append([H1], Res, List2).

% marble_naming(+Player:string, +Marble:string, -Res:atom)
% Auxiliary function that takes the string of the player and the marble and converts it into an atom that represents the marble
marble_naming(Player, Marble, Res) :- append("_", Marble, Suffix),
                                      append(Player, Suffix, Target),
                                      atom_string(Res, Target).

% clear_input()
% Clears the left over input in the console
clear_input:-peek_char('\n'), get_char(_), !.
clear_input:- get_code(_),
              clear_input.

% find_curve(+InitialCoordinates:pair(integer), +FinalCoordinates:pair(integer), -IndexFirstElement:integer, -IndexSecondElement:integer, Curve:list(pair(integer)))
% Auxiliary function used to check the valid moves in the curves. 
% Receives the initial coordinates and the final coordinates and makes sure that there is a curve where such move is possible by trying to find both elements inside the Curve list
find_curve(Li-Ci, Lf-Cf, IndexFirstElement, IndexSecondElement, Curve):- curve(Curve),
                                                                        nth0(IndexFirstElement, Curve, Li-Ci),
                                                                        nth0(IndexSecondElement, Curve, Lf-Cf).

% convert_to_board_elements(+Board:list(list(atom)), +Curve:list(pair(integer)), -Elements:list(atom))
% Auxiliary function used to convert the coordinates inside the Curve list to their values on the given board.
convert_to_board_elements(_, [], []).
convert_to_board_elements(Board, [L-C|Rest], Elements):- nth0(L, Board, Line),
                                                         nth0(C, Line, Element),
                                                         convert_to_board_elements(Board, Rest, Res),
                                                         append([Element], Res, Elements).

                                  