% check_new_move(+Marble, +Li-Ci, Lf-Cf)
% Checks if a new move by the player indicated in Marble is not a repeating one (to prevent cycles).
% Marble is an atom that represents the player's marble.
% Li-Ci is the initial location of the marble on the board.
% Lf-Cf is the final location of the marble on the board.
% The predicate succeeds if the player indicated in Marble has not made a previous move to the final location Lf-Cf from the initial location Li-Ci.
check_new_move(Marble, Li-Ci, Lf-Cf):- sub_atom(Marble, 0, 7, _, Player), \+prev_move(Player, Lf-Cf, Li-Ci).
                                                              
% valid_move_left(+Board, +Lidx_i-Cidx_i, +Lidx_i-Cidx_f)
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_i-Cidx_f) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_i-Cidx_f is the final position.
%
% A move is valid if:
%   - The final position is empty.
%   - All intermediate positions along the path are also empty.
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
valid_move_up(_, X-Y, X-Y).
valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                     nth0(Cidx_i, Line, empty),
                                                     NewX is (Lidx_f+1) mod 9,
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
valid_move_down(_, X-Y, X-Y).
valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                       nth0(Cidx_i, Line, empty),
                                                       NewX is (Lidx_f-1) mod 9,
                                                       valid_move_down(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

% valid_move(+Board, +Lidx_i-Cidx_i, +Lidx_f-Cidx_f)
% Determines if a move from the initial position (Lidx_i-Cidx_i) to the final position (Lidx_f-Cidx_f) is valid.
% Board is the current board state.
% Lidx_i-Cidx_i is the initial position.
% Lidx_f-Cidx_f is the final position.
%
% A move is valid if it is either a horizontal or vertical move and all the cells in the path are empty.
% A move is also valid if both the start and end positions are present in the same "curve/0" list and all the cells in the path are empty.
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
% A move is valid if it is a valid move according to the valid_move/3 predicate.
% If the move is not valid, the predicate writes a message to the output and fails.
check_valid_move(Board, L-C, LineDest-ColumnDest):- valid_move(Board, L-C, LineDest-ColumnDest).
check_valid_move(_, _-_, _-_):- write('You are not allowed to make that move!\n'), fail.