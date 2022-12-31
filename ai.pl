% get_all_moves_from_all_pos(+Board:list(list(atom)), +Coordinates:list(Coordinates:pair(integer)), -Moves:list(list(Coordinates:pair(integer))))
% Gets all the valid moves from a given list of positions
get_all_moves_from_all_pos(_, [], []).
get_all_moves_from_all_pos(Board, [L-C|Rest], Moves):-  get_all_moves_from_pos(Board, L-C, M1), 
                                                        get_all_moves_from_all_pos(Board, Rest, M2), 
                                                        append([M1], M2, Moves).

% movesSum(+List, -Score:integer)
% Sums the length of all the lists inside the List
movesSum([], 0).
movesSum([A|Rest], Score) :- movesSum(Rest, S1), length(A, M), Score is S1+M.


% evaluationScore(+Board:list(list(atom)), +Player:atom, -Score:integer)
% Calculates the score for a given board regarding a specific player. If Score > 0, favourable to player. Otherwise, unfavourable.
% In the case of game_over, the player is given a score of -1000.
% In the case of winning, the player is given a score of 10000000.
% In every other case, the score is calculated by summing all the possible player's moves and subtracting all the opponent player's move.
% The score is calculated this way because the more free (meaning more available moves) one player is over the other the better, because it means the other player is getting trapped and more likely to lose.
evaluationScore(Board, Player, -1000):- game_over(Board, Player), !.

evaluationScore(Board, Player, 10000000):-  next_player(Player, OpponentPlayer),
                                            game_over(Board, OpponentPlayer), !.

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

% all_boards_aux(+Board:list(list(atom)), +Player:atom, +Marble:atom, +Moves:list(Coordinates:pair(integer)), -NewBoards:list(list(list(atom))))
% Auxiliary function used in all_boards that for a list of Moves generates their corresponding boards for a given board.
all_boards_aux(_, _, _, [], []).
all_boards_aux(Board, Player, Marble, [L-C|RestListOfMoves], NewBoards):- findIndexesBoard(Board, Marble, L_ini-C_ini), 
                                                                          insert_in_board(Board, Marble, L, C, NB1), 
                                                                          insert_in_board(NB1, empty, L_ini, C_ini, NewBoard),
                                                                          all_boards_aux(Board, Player, Marble, RestListOfMoves, Res),
                                                                          append([NewBoard], Res, NewBoards).

% all_boards(+Board:list(list(atom)), +Player:atom, +Marbles:list(atom), +Moves:list(list(Coordinates:pair(integer))), -NewBoards:list(list(list(list(atom)))))
% Gets all the boards possible from a list of lists of Moves and returns the NewBoards in the same format.
all_boards(_, _, _, [], []).
all_boards(Board, Player, [FirstMarble|RestMarbles], [First|RestMoves], NewBoards):- all_boards_aux(Board, Player, FirstMarble, First, Res), 
                                                                                     all_boards(Board, Player, RestMarbles, RestMoves, Res2),
                                                                                     append([Res], Res2, NewBoards).

% allEvaluationScore(+Boards:list(list(list(atom))), +Player:atom, -Scores:list(integer))
% Returns a list of Evaluation Scores calculated from a given list of boards.
allEvaluationScore([], _, []).
allEvaluationScore([A|Rest], Player, Scores):- evaluationScore(A, Player, S1), allEvaluationScore(Rest, Player, S2), append([S1], S2, Scores).

% sublistBestEvaluationScore(+Boards:list(list(list(list(atom)))), +Player:atom, -Scores:list(integer), -Indexes:list(integer))
% Receives a list of lists of boards and for each board calculates its evaluation score. Then, from the list of scores, it gets the maximum value and it stores that score as well as its index to the Scores and Is.
% What is returned is a list of the maximum scores of the lists of Boards and the indexes that had that maximum score inside that list of boards.
sublistBestEvaluationScore([], _, [], []).
sublistBestEvaluationScore([[]|Rest], Player, Scores, Is):- sublistBestEvaluationScore(Rest, Player, Scores, Is).
sublistBestEvaluationScore([A|Rest], Player, Scores, Is):- allEvaluationScore(A, Player, S1), max_list(S1, M, I), sublistBestEvaluationScore(Rest, Player, S2, Is1), append([M], S2, Scores), append([I], Is1, Is).

% depthMinimaxCalls(+Boards:list(list(list(atom))), +Player:atom, +Depth:integer, +Minimizing?:integer, -NewBoards:list(list(list(atom))))
% Receives a list of boards and calls the minimax function for each board, afterwards it uses the best move given by the minimax function and applies it to the given board.
% Returns a list of boards with the best moves done.
% The Depth is passed through to the minimax.
% The Player and Minimizing? are used to determine who is the focus of the minimax and if the minimax should be maximizing or minimizing the move (depending on if the player (maximize) or the opponent's (minimize) turn)
depthMinimaxCalls([], _, _, _, []).

depthMinimaxCalls([A|Rest], Player, Depth, 1, NewBoards):-      next_player(Player, OppPlayer),
                                                                minimax(A, OppPlayer, Depth, 0, M, LM-CM, _),
                                                                atom_concat(_, N, M), atom_length(N, 1), atom_codes(N, TmpNumber), MarbleID is TmpNumber-48,
                                                                move(OppPlayer, MarbleID, A, LM-CM, NB),
                                                                depthMinimaxCalls(Rest, Player, Depth, 1, TmpNewBoards),
                                                                append([NB], TmpNewBoards, NewBoards).

depthMinimaxCalls([A|Rest], Player, Depth, 0, NewBoards):-      minimax(A, Player, Depth, 0, M, LM-CM, _),
                                                                atom_concat(_, N, M), atom_length(N, 1), atom_codes(N, TmpNumber), MarbleID is TmpNumber-48,
                                                                move(Player, MarbleID, A, LM-CM, NB),
                                                                depthMinimaxCalls(Rest, Player, Depth, 0, TmpNewBoards),
                                                                append([NB], TmpNewBoards, NewBoards).


% sublistDepthMinimaxCalls(+Boards:list(list(list(list(atom)))), +Player:atom, +Depth:integer, +Minimizing?:integer, -NewBoards:list(list(list(list(atom)))))
% Receives a list of lists of boards and calls the depthMinimaxCalls function for each list of boards.
% Returns a list of lists of boards with the best moves done.
% The Depth is passed through to the depthMinimaxCalls.
% The Player and Minimizing? are used to determine who is the focus of the minimax and if the minimax should be maximizing or minimizing the move (depending on if the player (maximize) or the opponent's (minimize) turn)
sublistDepthMinimaxCalls([], _, _, _, []).
sublistDepthMinimaxCalls([A|Rest], Player, Depth, 1, NextMoveBoards):-      depthMinimaxCalls(A, Player, Depth, 1, Boards),
                                                                            sublistDepthMinimaxCalls(Rest, Player, Depth, 1, TmpNextMoveBoards),
                                                                            append([Boards], TmpNextMoveBoards, NextMoveBoards).

sublistDepthMinimaxCalls([A|Rest], Player, Depth, 0, NextMoveBoards):-      depthMinimaxCalls(A, Player, Depth, 0, Boards),
                                                                            sublistDepthMinimaxCalls(Rest, Player, Depth, 0, TmpNextMoveBoards),
                                                                            append([Boards], TmpNextMoveBoards, NextMoveBoards).

% minimax(+Boards:list(list(atom)), +Player:atom, +Depth:integer, +Minimizing?:integer, -Coordinates:pair(integer), -Score:integer)
% Minimax algorithm: 
%   Depth: 0
%       Starts by getting all the boards for every possible move for the given player.
%       Calculates the evaluation scores for every board (sublistBestEvaluationScore)
%       Returns the move, marble and score with the highest/lowest score depending on the Minimizing? variable: 0 -> highest, 1 -> lowest
%   Depth: >0
%       Starts by getting all the boards for every possible move for the given player.
%       Calculates the boards with the posterior best moves determined recursively by minimax (sublistDepthMinimaxCalls)
%       Calculates the evaluation scores for every board calculated (sublistBestEvaluationScore)
%       Returns the move, marble and score with the highest/lowest score depending on the Minimizing? variable: 0 -> highest, 1 -> lowest
minimax(Board, Player, 0, 0, Marble, LineMove-ColumnMove, Score):-      marbles(Player, MarblesPlayer),
                                                                        get_all_positions(Board, MarblesPlayer, PositionsPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsPlayer, MP),
                                                                        all_boards(Board, Player, MarblesPlayer, MP, NewBoards),
                                                                        del_all([], MP, MovesPlayer),
                                                                        sublistBestEvaluationScore(NewBoards, Player, TmpScores, Is),
                                                                        max_list(TmpScores, Score, I),
                                                                        nth0(I, MarblesPlayer, Marble),
                                                                        nth0(I, Is, TmpI),
                                                                        nth0(I, MovesPlayer, TmpMoves),
                                                                        nth0(TmpI, TmpMoves, LineMove-ColumnMove).


minimax(Board, Player, 0, 1, Marble, LineMove-ColumnMove, Score):-      next_player(Player, OpponentPlayer),
                                                                        marbles(OpponentPlayer, MarblesOpponentPlayer),
                                                                        get_all_positions(Board, MarblesOpponentPlayer, PositionsOpponentPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsOpponentPlayer, MOP),
                                                                        all_boards(Board, OpponentPlayer, MarblesOpponentPlayer, MOP, NewBoards),
                                                                        del_all([], MOP, MovesOpponentPlayer),
                                                                        sublistBestEvaluationScore(NewBoards, Player, TmpScores, Is),
                                                                        min_list(TmpScores, Score, I),
                                                                        nth0(I, MarblesOpponentPlayer, Marble),
                                                                        nth0(I, Is, TmpI),
                                                                        nth0(I, MovesOpponentPlayer, TmpMoves),
                                                                        nth0(TmpI, TmpMoves, LineMove-ColumnMove).

minimax(Board, Player, Depth, 0, Marble, LineMove-ColumnMove, Score):-  marbles(Player, MarblesPlayer),
                                                                        get_all_positions(Board, MarblesPlayer, PositionsPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsPlayer, MP),
                                                                        all_boards(Board, Player, MarblesPlayer, MP, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 1, NextMoveBoards),
                                                                        del_all([], MP, MovesPlayer),
                                                                        sublistBestEvaluationScore(NextMoveBoards, Player, TmpScores, Is),
                                                                        max_list(TmpScores, Score, I),
                                                                        nth0(I, MarblesPlayer, Marble),
                                                                        nth0(I, Is, TmpI),
                                                                        nth0(I, MovesPlayer, TmpMoves),
                                                                        nth0(TmpI, TmpMoves, LineMove-ColumnMove).

minimax(Board, Player, Depth, 1, Marble, LineMove-ColumnMove, Score):-  next_player(Player, OpponentPlayer),
                                                                        marbles(OpponentPlayer, MarblesOpponentPlayer),
                                                                        get_all_positions(Board, MarblesOpponentPlayer, PositionsOpponentPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsOpponentPlayer, MOP),
                                                                        all_boards(Board, OpponentPlayer, MarblesOpponentPlayer, MOP, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 0, NextMoveBoards),
                                                                        del_all([], MOP, MovesOpponentPlayer),
                                                                        sublistBestEvaluationScore(NextMoveBoards, Player, TmpScores, Is),
                                                                        min_list(TmpScores, Score, I),
                                                                        nth0(I, MarblesOpponentPlayer, Marble),
                                                                        nth0(I, Is, TmpI),
                                                                        nth0(I, MovesOpponentPlayer, TmpMoves),
                                                                        nth0(TmpI, TmpMoves, LineMove-ColumnMove).

% best_move_ai(+Difficulty:atom, +Board:list(list(atom)), +Player:atom, -Marble:atom, -Coordinates:pair(integer))
% Function that calculates the next move for the computer from the given Board and Player according to the given Difficulty:
%   Easy -> Gets a random move from the given player
%   Medium -> Runs minimax with a depth of 0 (returns the move with the best score for that moment)
%   Hard -> Runs minimax with a depth of 1 (returns the move with the best score taking into account the following move from the opponent)
best_move_ai(easy, Board, Player, Marble, LineMove-ColumnMove):-   marbles(Player, MarblesNames),
                                                                get_all_positions(Board, MarblesNames, Positions),
                                                                get_all_moves_from_all_pos(Board, Positions, Moves),
                                                                length(Moves, LP1),
                                                                LenPos is LP1-1,
                                                                random(0, LenPos, N1),
                                                                nth0(N1, Moves, Ins),
                                                                length(Ins, LP2),
                                                                LenIns is LP2-1,
                                                                (       LenIns =:= 0 ->
                                                                                N2 = 0
                                                                ;       otherwise ->
                                                                                random(0, LenIns, N2)
                                                                ),
                                                                nth0(N2, Ins, LineMove-ColumnMove),
                                                                nth0(N1, MarblesNames, Marble).

best_move_ai(medium, Board, Player, Marble, LineMove-ColumnMove):- minimax(Board, Player, 0, 0, Marble, LineMove-ColumnMove, _).

best_move_ai(hard, Board, Player, Marble, LineMove-ColumnMove):- minimax(Board, Player, 1, 0, Marble, LineMove-ColumnMove, _).