:-use_module(library(lists)), use_module(library(random)).
:-use_module(library(between)).
:- dynamic bot_difficulty/2.

:- ['io.pl', 'utils.pl', 'ai.pl'].
start_board([
        [block, block, block, player2_1, empty, player2_2, block, block, block],
        [block, block, block, player2_3, empty, player2_4, block, block, block],
        [block, block, block, player2_5, empty, player2_6, block, block, block],
        [empty, empty, empty, player2_7, empty, player2_8, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, player1_7, empty, player1_8, empty, empty, empty],
        [block, block, block, player1_5, empty, player1_6, block, block, block],
        [block, block, block, player1_3, empty, player1_4, block, block, block],
        [block, block, block, player1_1, empty, player1_2, block, block, block]
        ]).

test3_board([
        [block, block, block, player2_1, empty, player2_2, block, block, block],
        [block, block, block, player2_3, empty, player2_4, block, block, block],
        [block, block, block, player2_5, player2_6, empty, block, block, block],
        [empty, empty, empty, player2_7, empty, player2_8, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, player1_8, empty, empty, empty],
        [block, block, block, player1_5, empty, player1_6, block, block, block],
        [block, block, block, player1_3, empty, player1_4, block, block, block],
        [block, block, block, player1_1, player1_7, player1_2, block, block, block]
        ]).

test_board([[block, block, block, player2_1, empty, player2_2, block, block, block],
        [block, block, block, player2_3, empty, player2_4, block, block, block],
        [block, block, block, player2_5, empty, player2_6, block, block, block],
        [empty, empty, empty, player2_7, empty, player2_8, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, player1_7, empty, player1_8, empty, empty, empty],
        [block, block, block, player1_5, empty, player1_6, block, block, block],
        [block, block, block, player1_3, empty, player1_4, block, block, block],
        [block, block, block, empty, player1_1, player1_2, block, block, block]]).

test2_board([[block, block, block, player2_1, empty, player2_2, block, block, block],
        [block, block, block, player2_3, empty, player2_4, block, block, block],
        [block, block, block, player2_5, empty, player2_6, block, block, block],
        [empty, empty, empty, empty, player2_7, player2_8, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, player1_7, empty, player1_8, empty, empty, empty],
        [block, block, block, empty, player1_5, player1_6, block, block, block],
        [block, block, block, player1_3, empty, player1_4, block, block, block],
        [block, block, block, player1_1, empty, player1_2, block, block, block]]).
size(9).

player(player1).
player(player2).

gamemode(1, hVh).
gamemode(2, hVc).
gamemode(3, cVh).
gamemode(4, cVc).

ai_level(1, easy).
ai_level(2, hard).


marbles(player1, [player1_1, player1_2, player1_3, player1_4, player1_5, player1_6, player1_7, player1_8]).
marbles(player2, [player2_1, player2_2, player2_3, player2_4, player2_5, player2_6, player2_7, player2_8]).

next_player(player1, player2).
next_player(player2, player1).


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
                                                  NewX is (Lidx_f+1) mod 9,
                                                  valid_move_up(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move_down(_, X-Y, X-Y).
valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- nth0(Lidx_f, Board, Line),
                                                  nth0(Cidx_i, Line, empty),
                                                  NewX is (Lidx_f-1) mod 9,
                                                  valid_move_down(Board, Lidx_i-Cidx_i, NewX-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i):- valid_move_up(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i);
                                                  valid_move_down(Board, Lidx_i-Cidx_i, Lidx_f-Cidx_i).

valid_move(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f):- valid_move_left(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f);
                                                  valid_move_right(Board, Lidx_i-Cidx_i, Lidx_i-Cidx_f).

marble_naming(Player, Marble, Res) :- append("_", Marble, Suffix),
                                      append(Player, Suffix, Target),
                                      atom_string(Res, Target).

get_all_moves_from_pos(Board, Lidx_i-Cidx_i, Moves):- findall(L-C, valid_move(Board, Lidx_i-Cidx_i, L-C), Res), 
                                             remove_dups(Res, Deduplicated),
                                             list_del(Deduplicated, Lidx_i-Cidx_i, Moves).

get_marble_position(Player, Marble, Board, Line-Column):- marble_naming(Player, Marble, Res),
                                                          findIndexesBoard(Board, Res, Line-Column).

move(Player, Marble, Board, Line-Column, NewBoard):-     atom_string(Player, PlayerString),
                                                                atom_string_number(Marble, MarbleString),
                                                                get_marble_position(PlayerString, MarbleString, Board, L-C),
                                                                valid_move(Board, L-C, Line-Column),
                                                                marble_naming(PlayerString, MarbleString, Res),
                                                                insert_in_board(Board, Res, Line, Column, NB1),
                                                                insert_in_board(NB1, empty, L, C, NewBoard).

get_all_positions(_, [], []).
get_all_positions(Board, [FirstMarble|Rest], Positions):- findIndexesBoard(Board, FirstMarble, L-C),
                                                          get_all_positions(Board, Rest, Res),
                                                          append([L-C], Res, Positions).

check_all_moves(_, []).
check_all_moves(Board, [L-C|Tail]):- get_all_moves_from_pos(Board, L-C, Res),
                                     \+length(Res, 0),
                                     check_all_moves(Board, Tail).


check_valid_move(Board, L-C, LineDest-ColumnDest):- valid_move(Board, L-C, LineDest-ColumnDest).
check_valid_move(_, _-_, _-_):- write('You are not allowed to make that move!\n'),
                                                     fail.

make_move(Player, Board, NewBoard):- retrieve_command(Player, Marble, LineDest-ColumnDest),
                                     atom_string(Player, PlayerString),
                                     atom_string_number(Marble, MarbleString),
                                     get_marble_position(PlayerString, MarbleString, Board, L-C),!,
                                     check_valid_move(Board, L-C, LineDest-ColumnDest),
                                     move(Player, Marble, Board, LineDest-ColumnDest, NewBoard).

make_move_ai(easy, Player, Board, NewBoard):- best_move_ai(0, Board, Player, Marble, LineMove-ColumnMove),
                                              findIndexesBoard(Board, Marble, Line-Column),
                                              insert_in_board(Board, Marble, LineMove, ColumnMove, NB1),
                                              insert_in_board(NB1, empty, Line, Column, NewBoard).

make_move_ai(hard, Player, Board, NewBoard):- best_move_ai(0, Board, Player, Marble, LineMove-ColumnMove),
                                              findIndexesBoard(Board, Marble, Line-Column),
                                              insert_in_board(Board, Marble, LineMove, ColumnMove, NB1),
                                              insert_in_board(NB1, empty, Line, Column, NewBoard).

play:- start_board(Board),
            player(Player),
            display_game(Board),
            start_menu(GameMode),
            !,
            game_cycle_wrapper(GameMode, Board-Player).

game_cycle_wrapper(hVh, Board-Player):- game_cycle(hVh, Board-Player).
game_cycle_wrapper(cVh, Board-Player):- set_ai_level(Level),
                                        assert(bot_difficulty(player1, Level)),
                                        game_cycle(cVh, Board-Player).

game_cycle_wrapper(hVc, Board-Player):- set_ai_level(Level),
                                        assert(bot_difficulty(player2, Level)),
                                        game_cycle(hVc, Board-Player).

game_cycle_wrapper(cVc, Board-Player):- set_ai_level(Level1),
                                        assert(bot_difficulty(player1, Level1)),
                                        set_ai_level(Level2),
                                        assert(bot_difficulty(player2, Level2)),
                                        game_cycle(cVc, Board-Player).

game_over(Board, Player):- marbles(Player, MarblesNames),
                           get_all_positions(Board, MarblesNames, Positions),
                           \+check_all_moves(Board, Positions).

game_cycle(_, Board-Player):-game_over(Board, Player), !,
                           next_player(Player, NextPlayer),
                           congratulate(NextPlayer),
                           retractall(bot_difficulty(_, _)).

game_cycle(hVh, Board-Player):- repeat,
                           make_move(Player, Board, NewBoard),
                           next_player(Player, NextPlayer),
                           display_game(NewBoard),
                           game_cycle(hVh, NewBoard-NextPlayer).

game_cycle(hVc, Board-player1):- repeat,
                                 make_move(player1, Board, NewBoard),
                                 next_player(player1, NextPlayer),
                                 game_cycle(hVc, NewBoard-NextPlayer).

game_cycle(hVc, Board-player2):- bot_difficulty(player2, Level),
                                 make_move_ai(Level, player2, Board, NewBoard),
                                 next_player(player2, NextPlayer),
                                 display_game(NewBoard),
                                 game_cycle(hVc, NewBoard-NextPlayer).

game_cycle(cVh, Board-player1):- bot_difficulty(player1, Level),
                                 make_move_ai(Level, player1, Board, NewBoard),
                                 next_player(player1, NextPlayer),
                                 display_game(NewBoard),
                                 game_cycle(cVh, NewBoard-NextPlayer).

game_cycle(cVh, Board-player2):- repeat,
                                 make_move(player2, Board, NewBoard),
                                 next_player(player2, NextPlayer),
                                 game_cycle(cVh, NewBoard-NextPlayer).

game_cycle(cVc, Board-Player):- bot_difficulty(Player, Level),
                                make_move_ai(Level, Player, Board, NewBoard),
                                next_player(Player, NextPlayer),
                                write(Player), write(' played!\n\n'),
                                display_game(NewBoard),
                                game_cycle(cVc, NewBoard-NextPlayer).


% reconsult('main.pl'), start_board(Board), best_move_ai(1, Board, player1, M, L-C).