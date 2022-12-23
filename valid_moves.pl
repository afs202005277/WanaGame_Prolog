get_new_value_left(LineIndex, CurrentColIndex, NewColIndex):- LineIndex < 3,
                                                              NewColIndex is 3 + ((CurrentColIndex-1) mod 3).

get_new_value_left(LineIndex, CurrentColIndex, NewColIndex):- LineIndex > 5,
                                                              NewColIndex is 3 + ((CurrentColIndex-1) mod 3).

get_new_value_left(LineIndex, CurrentColIndex, NewColIndex):- LineIndex >= 3, LineIndex =< 5, NewColIndex is (CurrentColIndex-1) mod 9.

get_new_value_right(LineIndex, CurrentColIndex, NewColIndex):- LineIndex < 3,
                                                              NewColIndex is 3 + ((CurrentColIndex+1) mod 3).

get_new_value_right(LineIndex, CurrentColIndex, NewColIndex):- LineIndex > 5,
                                                              NewColIndex is 3 + ((CurrentColIndex+1) mod 3).
get_new_value_right(LineIndex, CurrentColIndex, NewColIndex):- LineIndex >= 3, LineIndex =< 5, NewColIndex is (CurrentColIndex+1) mod 9.

get_new_value_up(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex < 3,
                                                              NewLineIndex is 3 + ((LineIndex+1) mod 3).

get_new_value_up(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex > 5,
                                                              NewLineIndex is 3 + ((LineIndex+1) mod 3).

get_new_value_up(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex >= 3, CurrentColIndex =< 5, NewLineIndex is (LineIndex+1) mod 9.

get_new_value_down(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex < 3,
                                                              NewLineIndex is 3 + ((LineIndex-1) mod 3).

get_new_value_down(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex > 5,
                                                              NewLineIndex is 3 + ((LineIndex-1) mod 3).

get_new_value_down(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex >= 3, CurrentColIndex =< 5, NewLineIndex is (LineIndex-1) mod 9.
                                                              

valid_move_left(_, X-Y, X-Y).
valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                       nth0(Cidx_f, Line, empty),
                                                       get_new_value_left(Lidx_i, Cidx_f, NewY),
                                                       valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move_right(_, X-Y, X-Y).
valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, empty),
                                                  get_new_value_right(Lidx_i, Cidx_f, NewY),
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

valid_move_up(_, X-Y, X-Y).
valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  get_new_value_up(Lidx_f, Cidx_i, NewX),
                                                  valid_move_up(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move_down(_, X-Y, X-Y).
valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  get_new_value_down(Lidx_f, Cidx_i, NewX),
                                                  valid_move_down(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i);
                                                  valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f);
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f).

check_valid_move(Board, L-C, LineDest-ColumnDest):- valid_move(Board, L-C, LineDest-ColumnDest).
check_valid_move(_, _-_, _-_):- write('You are not allowed to make that move!\n'), fail.