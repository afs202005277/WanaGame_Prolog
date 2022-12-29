% Gets all the valid moves from a given list of positions
get_all_moves_from_all_pos(_, [], []).
get_all_moves_from_all_pos(Board, [L-C|Rest], Moves):-  get_all_moves_from_pos(Board, L-C, M1), 
                                                        get_all_moves_from_all_pos(Board, Rest, M2), 
                                                        append([M1], M2, Moves).

% Gets the list in a given index from a multidmensional array
choose_from_list([], _, []).
choose_from_list([A|_], 0, A).
choose_from_list([_|Rest], X, RetList):- length(Rest, S), Size is S+1, X<Size, X>0, X1 is X-1, choose_from_list(Rest, X1, RetList).

% Sums all the values in a list
movesSum([], 0).
movesSum([A|Rest], Score) :- movesSum(Rest, S1), length(A, M), Score is S1+M.


evaluationScore(Board, Player, -10000000):- game_over(Board, Player), !.

evaluationScore(Board, Player, 10000000):-  next_player(Player, OpponentPlayer),
                                            game_over(Board, OpponentPlayer), !.

% Calculates the evaluation score of a given board
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

% Auxiliary function used in all_boards that makes the given moves and returns boards
all_boards_aux(_, _, _, [], []).
all_boards_aux(Board, Player, Marble, [L-C|RestListOfMoves], NewBoards):- findIndexesBoard(Board, Marble, L_ini-C_ini), 
                                                                          insert_in_board(Board, Marble, L, C, NB1), 
                                                                          insert_in_board(NB1, empty, L_ini, C_ini, NewBoard),
                                                                          all_boards_aux(Board, Player, Marble, RestListOfMoves, Res),
                                                                          append([NewBoard], Res, NewBoards).

% Gets all the boards possible from a list of marbles and a list of designated moves
all_boards(_, _, _, [], []).
all_boards(Board, Player, [FirstMarble|RestMarbles], [First|RestMoves], NewBoards):- all_boards_aux(Board, Player, FirstMarble, First, Res), 
                                                                                     all_boards(Board, Player, RestMarbles, RestMoves, Res2),
                                                                                     append([Res], Res2, NewBoards).

% Returns an array of Evaluation Scores from an array of Boards
allEvaluationScore([], _, []).
allEvaluationScore([A|Rest], Player, Scores):- evaluationScore(A, Player, S1), allEvaluationScore(Rest, Player, S2), append([S1], S2, Scores).

% Returns a multidimensional array of Scores from a multidimensional array of boards
sublistBestEvaluationScore([], _, [], []).
sublistBestEvaluationScore([[]|Rest], Player, Scores, Is):- sublistBestEvaluationScore(Rest, Player, Scores, Is).
sublistBestEvaluationScore([A|Rest], Player, Scores, Is):- allEvaluationScore(A, Player, S1), max_list(S1, M, I), sublistBestEvaluationScore(Rest, Player, S2, Is1), append([M], S2, Scores), append([I], Is1, Is).

% Calls minimax recursively and returns an array of evaluation score from an array of Boards
depthMinimaxCalls([], _, _, _, [], []).

depthMinimaxCalls([A|Rest], Player, Depth, 1, LCs, Scores):-   minimax(A, Player, Depth, 1, M, LM-CM, S1),
                                                                depthMinimaxCalls(Rest, Player, Depth, 1, TmpLCs, TmpScores),
                                                                append([LM-CM], TmpLCs, LCs),
                                                                append([S1], TmpScores, Scores).

depthMinimaxCalls([A|Rest], Player, Depth, 0, LCs, Scores):-   minimax(A, Player, Depth, 0, M, LM-CM, S1),
                                                                depthMinimaxCalls(Rest, Player, Depth, 0, TmpLCs, TmpScores),
                                                                append([LM-CM], TmpLCs, LCs),
                                                                append([S1], TmpScores, Scores).

% Calls minimax recursively and returns an multidimensional array of evaluation scores from a multidimensional array of Boards
sublistDepthMinimaxCalls([], _, _, _, [], []).
sublistDepthMinimaxCalls([A|Rest], Player, Depth, 1, LCs, Scores):-     depthMinimaxCalls(A, Player, Depth, 1, LCs1, Scores1),
                                                                        sublistDepthMinimaxCalls(Rest, Player, Depth, 1, LCs2, Scores2),
                                                                        append([LCs1], LCs2, LCs),
                                                                        append([Scores1], Scores2, Scores).

sublistDepthMinimaxCalls([A|Rest], Player, Depth, 0, LCs, Scores):-     depthMinimaxCalls(A, Player, Depth, 0, LCs1, Scores1),
                                                                        sublistDepthMinimaxCalls(Rest, Player, Depth, 0, LCs2, Scores2),
                                                                        append([Scores1], Scores2, Scores),
                                                                        append([LCs1], LCs2, LCs).

% Minimax algorithm, receives the current board, the player, the depth and if it is the current's player turn and returns the best move possible.
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

% Auxiliary 'map' function that works with multidimensional arrays
mapDoubleList(_, [], []).
mapDoubleList(Pred, [H|T], [M|Ms]) :-
    call(Pred, H, M, _),
    mapDoubleList(Pred, T, Ms).

% Auxiliary function that gets the index of the list that has the maximum value
max_list_index(Lists, Index) :-
    mapDoubleList(max_list, Lists, Maxes),
    max_list(Maxes, Max, Index).

% Auxiliary function that gets the index of the list that has the minimum value
min_list_index(Lists, Index) :-
    mapDoubleList(min_list, Lists, Mins),
    max_list(Mins, Min, Index).


minimax(Board, Player, Depth, 0, Marble, LineMove-ColumnMove, Score):-  marbles(Player, MarblesPlayer),
                                                                        get_all_positions(Board, MarblesPlayer, PositionsPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsPlayer, MovesPlayer),
                                                                        all_boards(Board, Player, MarblesPlayer, MovesPlayer, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 1, LCs, Scores),
                                                                        max_list_index(Scores, MarbleInd),
                                                                        nth0(MarbleInd, Scores, MarbleScores),
                                                                        nth0(MarbleInd, MovesPlayer, MarbleMoves),
                                                                        max_list(MarbleScores, Score, I),
                                                                        nth0(I, MarbleMoves, LineMove-ColumnMove),
                                                                        nth0(MarbleInd, MarblesPlayer, Marble).

minimax(Board, Player, Depth, 1, Marble, LineMove-ColumnMove, Score):-  next_player(Player, OpponentPlayer),
                                                                        marbles(OpponentPlayer, MarblesOpponentPlayer),
                                                                        get_all_positions(Board, MarblesOpponentPlayer, PositionsOpponentPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsOpponentPlayer, MovesOpponentPlayer),
                                                                        all_boards(Board, OpponentPlayer, MarblesOpponentPlayer, MovesOpponentPlayer, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 0, LCs, Scores),
                                                                        min_list_index(Scores, MarbleInd),
                                                                        nth0(MarbleInd, Scores, MarbleScores),
                                                                        nth0(MarbleInd, MovesOpponentPlayer, MarbleMoves),
                                                                        min_list(MarbleScores, Score, I),
                                                                        nth0(I, MarbleMoves, LineMove-ColumnMove),
                                                                        nth0(MarbleInd, MarblesOpponentPlayer, Marble).

% Function that decides the best move, easy -> does random move, hard -> uses the minimax algorithm
best_move_ai(easy, Board, Player, Marble, LineMove-ColumnMove):-   marbles(Player, MarblesNames),
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

best_move_ai(medium, Board, Player, Marble, LineMove-ColumnMove):- minimax(Board, Player, 0, 0, Marble, LineMove-ColumnMove, _).

best_move_ai(hard, Board, Player, Marble, LineMove-ColumnMove):- minimax(Board, Player, 1, 0, Marble, LineMove-ColumnMove, _).