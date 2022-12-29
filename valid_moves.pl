check_new_move(Marble, Li-Ci, Lf-Cf):- sub_atom(Marble, 0, 7, _, Player), \+prev_move(Player, Lf-Cf, Li-Ci).

% get_new_value_up(+LineIndex, +CurrentColIndex, -NewLineIndex)
% Computes the new row index after a move up.
% LineIndex is the current row index.
% CurrentColIndex is the current column index.
% NewLineIndex is the new row index after the move.
%
% The new row index is computed as follows:
%   - If CurrentColIndex < 3, then NewLineIndex is 3 + ((LineIndex+1) mod 3).
%   - If CurrentColIndex > 5, then NewLineIndex is 3 + ((LineIndex+1) mod 3).
%   - If CurrentColIndex is between 3 and 5 (inclusive), then NewLineIndex is (LineIndex+1) mod 9.
get_new_value_up(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex < 3,
                                                              NewLineIndex is 3 + ((LineIndex+1) mod 3).

get_new_value_up(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex > 5,
                                                              NewLineIndex is 3 + ((LineIndex+1) mod 3).

get_new_value_up(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex >= 3, CurrentColIndex =< 5, NewLineIndex is (LineIndex+1) mod 9.

% get_new_value_down(+LineIndex, +CurrentColIndex, -NewLineIndex)
% Computes the new row index after a move down.
% LineIndex is the current row index.
% CurrentColIndex is the current column index.
% NewLineIndex is the new row index after the move.
%
% The new row index is computed as follows:
%   - If CurrentColIndex < 3, then NewLineIndex is 3 + ((LineIndex-1) mod 3).
%   - If CurrentColIndex > 5, then NewLineIndex is 3 + ((LineIndex-1) mod 3).
%   - If CurrentColIndex is between 3 and 5 (inclusive), then NewLineIndex is (LineIndex-1) mod 9.
get_new_value_down(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex < 3,
                                                              NewLineIndex is 3 + ((LineIndex-1) mod 3).

get_new_value_down(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex > 5,
                                                              NewLineIndex is 3 + ((LineIndex-1) mod 3).

get_new_value_down(LineIndex, CurrentColIndex, NewLineIndex):- CurrentColIndex >= 3, CurrentColIndex =< 5, NewLineIndex is (LineIndex-1) mod 9.
                                                              
% valid_move_left(+Board, +Lidx_i-Cidx_i, +Lidx_i-Cidx_f)
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_i-Cidx_f) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_i-Cidx_f is the final position.
%
% A move is valid if:
%   - The final position is empty.
%   - All intermediate positions along the path are also empty.
% The intermediate positions are iterated using the get_new_value_left/3 predicate.
valid_move_left(_, X-Y, X-Y).
valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                       nth0(Cidx_f, Line, empty),
                                                       length(Line, Length),
                                                       NewY is (Cidx_f-1) mod Length,
                                                       valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

% valid_move_right(+Board, +Lidx_i-Cidx_i, +Lidx_i-Cidx_f)
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_i-Cidx_f) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_i-Cidx_f is the final position.
%
% A move is valid if:
%   - The final position is empty.
%   - All intermediate positions along the path are also empty.
% The intermediate positions are iterated using the get_new_value_right/3 predicate.
valid_move_right(_, X-Y, X-Y).
valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_f, Line, empty),
                                                  length(Line, Length),
                                                  NewY is (Cidx_f+1) mod Length,
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-NewY).

% valid_move_up(+Board, +Lidx_i-Cidx_i, +Lidx_f-Cidx_i)
%
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_f-Cidx_i) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_f-Cidx_i is the final position.
%
% A move is valid if:
%   - The final position is empty.
%   - All intermediate positions along the path are also empty.
% The intermediate positions are iterated using the get_new_value_up/3 predicate.
valid_move_up(_, X-Y, X-Y).
valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  get_new_value_up(Lidx_f, Cidx_i, NewX),
                                                  valid_move_up(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

% valid_move_down(+Board, +Lidx_i-Cidx_i, +Lidx_f-Cidx_i)
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_f-Cidx_i) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_f-Cidx_i is the final position.
%
% A move is valid if:
%   - The final position is empty.
%   - All intermediate positions along the path are also empty.
% The intermediate positions are iterated using the get_new_value_down/3 
valid_move_down(_, X-Y, X-Y).
valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  get_new_value_down(Lidx_f, Cidx_i, NewX),
                                                  valid_move_down(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

% valid_move(+Board, +Lidx_i-Cidx_i, +Lidx_f-Cidx_f)
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_f-Cidx_f) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_f-Cidx_f is the final position.
%
% A move is valid if it is either a horizontal or vertical move and all the cells in the path are empty.
% Furthermore, the move is valid if the initial position is different from the final one.
valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- Lidx_i \== Lidx_f,
                                                  nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_i, Line, Marble),
                                                  check_new_move(Marble, Lidx_f-Cidx_i, Lidx_i-Cidx_i),
                                                  (valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i);
                                                  valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i)).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- Cidx_i \== Cidx_f,
                                                  nth0(Lidx_i, Board, Line),
                                                  nth0(Cidx_i, Line, Marble),
                                                  check_new_move(Marble, Lidx_i-Cidx_f, Lidx_i-Cidx_i),
                                                  (valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f);
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f)).

valid_move(Board, Li-Ci, Lf-Cf):- Li-Ci \== Lf-Cf,
                                  nth0(Li, Board, Line),
                                  nth0(Ci, Line, Marble),
                                  check_new_move(Marble, Lf-Cf, Li-Ci),
                                  find_curve(Li-Ci, Lf-Cf, IndexFirst, IndexSecond, Curve),
                                  convert_to_board_elements(Board, Curve, Elements),
                                  (valid_move_right([Elements], 0-IndexFirst, 0-IndexSecond);
                                  valid_move_left([Elements], 0-IndexFirst, 0-IndexSecond)).

% check_valid_move(+Board, +L-C, +LineDest-ColumnDest)
% Checks if a move is valid, and if not, writes a message to the user.
% Board is the current board state.
% L-C is the initial position of the move.
% LineDest-ColumnDest is the final position of the move.
%
% A move is valid if it is a valid move according to the valid_move/4 predicate.
% If the move is not valid, the predicate writes a message to the output and fails.
check_valid_move(Board, L-C, LineDest-ColumnDest):- valid_move(Board, L-C, LineDest-ColumnDest).
check_valid_move(_, _-_, _-_):- write('You are not allowed to make that move!\n'), fail.