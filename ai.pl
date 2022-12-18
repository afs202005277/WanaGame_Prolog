get_all_moves_from_all_pos(_, [], []).
get_all_moves_from_all_pos(Board, [L-C|Rest], Moves):-  get_all_moves_from_pos(Board, L-C, M1), 
                                                        get_all_moves_from_all_pos(Board, Rest, M2), 
                                                        append([M1], M2, Moves).

choose_from_list([], _, []).
choose_from_list([A|_], 0, A).
choose_from_list([_|Rest], X, RetList):- length(Rest, S), Size is S+1, X<Size, X>0, X1 is X-1, choose_from_list(Rest, X1, RetList).

movesSum([], 0).
movesSum([A|Rest], Score) :- movesSum(Rest, S1), length(A, M), Score is S1+M.

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

all_boards_aux(_, _, _, [], []).
all_boards_aux(Board, Player, Marble, [L-C|RestListOfMoves], NewBoards):- findIndexesBoard(Board, Marble, L_ini-C_ini), 
                                                                          insert_in_board(Board, Marble, L, C, NB1), 
                                                                          insert_in_board(NB1, empty, L_ini, C_ini, NewBoard),
                                                                          all_boards_aux(Board, Player, Marble, RestListOfMoves, Res),
                                                                          append([NewBoard], Res, NewBoards).

all_boards(_, _, _, [], []).
all_boards(Board, Player, [FirstMarble|RestMarbles], [First|RestMoves], NewBoards):- all_boards_aux(Board, Player, FirstMarble, First, Res), 
                                                                                     all_boards(Board, Player, RestMarbles, RestMoves, Res2),
                                                                                     append([Res], Res2, NewBoards).

allEvaluationScore([], _, []).
allEvaluationScore([A|Rest], Player, Scores):- evaluationScore(A, Player, S1), allEvaluationScore(Rest, Player, S2), append([S1], S2, Scores).

sublistBestEvaluationScore([], _, [], []).
sublistBestEvaluationScore([[]|Rest], Player, Scores, Is):- sublistBestEvaluationScore(Rest, Player, Scores, Is).
sublistBestEvaluationScore([A|Rest], Player, Scores, Is):- allEvaluationScore(A, Player, S1), max_list(S1, M, I), sublistBestEvaluationScore(Rest, Player, S2, Is1), append([M], S2, Scores), append([I], Is1, Is).

depthMinimaxCalls([], _, _, _, [], []).

depthMinimaxCalls([A|Rest], Player, Depth, 1, MLCs, Scores):-   minimax(A, Player, Depth, 1, M, LM-CM, S1),
                                                                depthMinimaxCalls(Rest, Player, Depth, 1, TmpMLCs, TmpScores),
                                                                append([M-LM-CM], TmpMLCs, MLCs),
                                                                append([S1], TmpScores, Scores).

depthMinimaxCalls([A|Rest], Player, Depth, 0, MLCs, Scores):-   minimax(A, Player, Depth, 0, M, LM-CM, S1),
                                                                depthMinimaxCalls(Rest, Player, Depth, 0, TmpMLCs, TmpScores),
                                                                append([M-LM-CM], TmpMLCs, MLCs),
                                                                append([S1], TmpScores, Scores).

andreSousa([], [], -100000000, player1_1-2-2).
andreSousa(Scores1, MLCs1, S1, MLC1):- max_list(Scores1, S1, I1), nth0(I1, MLCs1, MLC1).

sousaAndre([], [], 100000000, player2_1-2-2).
sousaAndre(Scores1, MLCs1, S1, MLC1):- min_list(Scores1, S1, I1), nth0(I1, MLCs1, MLC1).

sublistDepthMinimaxCalls([], _, _, _, [], []).
sublistDepthMinimaxCalls([A|Rest], Player, Depth, 1, MLCs, Scores):-    depthMinimaxCalls(A, Player, Depth, 1, MLCs1, Scores1),
                                                                        andreSousa(Scores1, MLCs1, S1, MLC1),
                                                                        sublistDepthMinimaxCalls(Rest, Player, Depth, 1, MLCs2, Scores2),
                                                                        append([S1], Scores2, Scores),
                                                                        append([MLC1], MLCs2, MLCs).

sublistDepthMinimaxCalls([A|Rest], Player, Depth, 0, MLCs, Scores):-    depthMinimaxCalls(A, Player, Depth, 0, MLCs1, Scores1),
                                                                        sousaAndre(Scores1, MLCs1, S1, MLC1),
                                                                        sublistDepthMinimaxCalls(Rest, Player, Depth, 0, MLCs2, Scores2),
                                                                        append([S1], Scores2, Scores),
                                                                        append([MLC1], MLCs2, MLCs).

minimax(Board, Player, 0, 1, Marble, LineMove-ColumnMove, Score):-      marbles(Player, MarblesPlayer),
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


minimax(Board, Player, 0, 0, Marble, LineMove-ColumnMove, Score):-      next_player(Player, OpponentPlayer),
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
                                                                        get_all_moves_from_all_pos(Board, PositionsPlayer, MovesPlayer),
                                                                        all_boards(Board, Player, MarblesPlayer, MovesPlayer, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 1, MLCs, Scores),
                                                                        max_list(Scores, Score, I),
                                                                        nth0(I, MLCs, Marble-LineMove-ColumnMove).


minimax(Board, Player, Depth, 1, Marble, LineMove-ColumnMove, Score):-  next_player(Player, OpponentPlayer),
                                                                        marbles(OpponentPlayer, MarblesOpponentPlayer),
                                                                        get_all_positions(Board, MarblesOpponentPlayer, PositionsOpponentPlayer),
                                                                        get_all_moves_from_all_pos(Board, PositionsOpponentPlayer, MovesOpponentPlayer),
                                                                        all_boards(Board, OpponentPlayer, MarblesOpponentPlayer, MovesOpponentPlayer, NewBoards),
                                                                        D1 is Depth-1,
                                                                        sublistDepthMinimaxCalls(NewBoards, Player, D1, 0, MLCs, Scores),
                                                                        %write(MLCs), nl, write(Scores),nl,
                                                                        min_list(Scores, Score, I),
                                                                        nth0(I, MLCs, Marble-LineMove-ColumnMove).

best_move_ai(0, Board, Player, Marble, LineMove-ColumnMove):-   marbles(Player, MarblesNames),
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

best_move_ai(1, Board, Player, Marble, LineMove-ColumnMove):- minimax(Board, Player, 3, 0, Marble, LineMove-ColumnMove, _).