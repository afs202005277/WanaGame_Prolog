:-use_module(library(lists)), use_module(library(random)), use_module(library(between)).
:-dynamic bot_difficulty/2, prev_move/3.
:- ['io.pl', 'utils.pl', 'ai.pl', 'valid_moves.pl'].

% start_board(-Board:list(list(atom))) 
% Initializes the game board as a list of lists of atoms.
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

curve([2-3, 2-4, 2-5, 3-6, 4-6, 5-6, 6-5, 6-4, 6-3, 5-2, 4-2, 3-2]).
curve([1-3, 1-4, 1-5, 3-7, 4-7, 5-7, 7-5, 7-4, 7-3, 5-1, 4-1, 3-1]).
curve([0-3, 0-4, 0-5, 3-8, 4-8, 5-8, 8-5, 8-4, 8-3, 5-0, 4-0, 3-0]).

% size(-Size:integer)
% Initializes the size of the game board as an integer.
size(9).

prev_move(player0_0, 0-0, 0-0).

% player(-Player:atom)
% Yields the atoms representing the players.
player(player1).
player(player2).

% marbles(+Player:atom, -Marbles:list(atom))
% Returns a list of atoms representing the marbles of a player.
marbles(player1, [player1_1, player1_2, player1_3, player1_4, player1_5, player1_6, player1_7, player1_8]).
marbles(player2, [player2_1, player2_2, player2_3, player2_4, player2_5, player2_6, player2_7, player2_8]).

% gamemode(+Option:integer, -GameMode:atom)
% Validates an integer as a game mode option (1, 2, 3, or 4).
% Returns the corresponding game mode atom.
% Fails if the option is invalid.
gamemode(1, hVh).
gamemode(2, hVc).
gamemode(3, cVh).
gamemode(4, cVc).

% ai_level(+Option:integer, -Level:atom) 
% Validates an integer as an AI level option (1 or 2).
% Returns the corresponding level atom.
% Fails if the option is invalid.
ai_level(1, easy).
ai_level(2, medium).
ai_level(3, hard).

% next_player(+Player:atom, -NextPlayer:atom) 
% Returns the next player in the game based on the current player.
next_player(player1, player2).
next_player(player2, player1).

% get_all_moves_from_pos(+Board:list(list(atom)), +Coordinates:pair(integer), -Moves:list(pair(integer))) 
% Returns a list of valid moves for a marble at a given position on the board.
% The board is represented as a list of lists of atoms, and the position is given
get_all_moves_from_pos(Board, Lidx_i-Cidx_i, Moves):- findall(L-C, valid_move(Board, Lidx_i-Cidx_i, L-C), Res), 
                                             remove_dups(Res, Deduplicated),
                                             list_del(Deduplicated, Lidx_i-Cidx_i, Moves).

% get_marble_position(+Player:atom, +Marble:atom, +Board:list(list(atom)), -Coordinates:pair(integer)) 
% Returns the coordinates of a marble on the board.
% The board is represented as a list of lists of atoms, the player is an atom, and the marble is an atom.
get_marble_position(Player, Marble, Board, Line-Column):- marble_naming(Player, Marble, Res),
                                                          findIndexesBoard(Board, Res, Line-Column).

% move(+Player:atom, +Marble:atom, +Board:list(list(atom)), +Coordinates:pair(integer), -NewBoard:list(list(atom))) 
% Makes a move on the board for a given player and marble, and returns the resulting board.
% The board is represented as a list of lists of atoms, the player is an atom, the marble is an atom, and the coordinates are given as a pair of integers.
% Fails if the move is not valid.
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

% check_all_moves(+Board:list(list(atom)), +Positions:list(pair(integer))) 
% Validates that all marbles have at least one valid move.
% The board is represented as a list of lists of atoms, and the positions are given as a list of pairs of integers.
% Fails if at least one marble has no valid moves.
check_all_moves(_, []).
check_all_moves(Board, [L-C|Tail]):- get_all_moves_from_pos(Board, L-C, Res),
                                     \+length(Res, 0),
                                     check_all_moves(Board, Tail).

% make_move(+Player:atom, +Board:list(list(atom)), -NewBoard:list(list(atom))) 
% Makes a move for a given player and returns the resulting board.
% The board is represented as a list of lists of atoms, and the player is an atom.
make_move(Player, Board, NewBoard):- retrieve_command(Player, Marble, LineDest-ColumnDest),
                                     atom_string(Player, PlayerString),
                                     atom_string_number(Marble, MarbleString),
                                     get_marble_position(PlayerString, MarbleString, Board, L-C),!,
                                     check_valid_move(Board, L-C, LineDest-ColumnDest),
                                     move(Player, Marble, Board, LineDest-ColumnDest, NewBoard).

remove_prev_move(Marble):- retract(prev_move(Marble, _-_, _-_)).
remove_prev_move(_).

% make_move_ai(+Difficulty:atom, +Player:atom, +Board:list(list(atom)), -NewBoard:list(list(atom)))
% Makes a move for an AI player and returns the resulting board.
% The difficulty level is an atom, the board is represented as a list of lists of atoms, and the player is an atom.
make_move_ai(Difficulty, Player, Board, NewBoard):- best_move_ai(Difficulty, Board, Player, Marble, LineMove-ColumnMove),
                                              findIndexesBoard(Board, Marble, Line-Column),
                                              remove_prev_move(Marble),
                                              assert(prev_move(Marble, Line-Column, LineMove-ColumnMove)),
                                              insert_in_board(Board, Marble, LineMove, ColumnMove, NB1),
                                              insert_in_board(NB1, empty, Line, Column, NewBoard).

% Main entry point of the game. Initializes the board, displays it, and starts the game with a selected game mode.
play:- start_board(Board),
            player(Player),
            display_game(Board),
            start_menu(GameMode),
            !,
            game_cycle_wrapper(GameMode, Board-Player).

% game_cycle_wrapper(+GameMode:atom, +Board-Player:pair(list(list(atom)), atom)) 
% Wrapper function to handle the different game modes. Initializes AI difficulty level if needed.
% The game mode is an atom and the board and current player are represented as a pair (list of lists of atoms and atom).
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

% game_over(+Board:list(list(atom)), +Player:atom) 
% Determines if the game is over for the given player.
% The board is represented as a list of lists of atoms and the player is an atom.
game_over(Board, Player):- marbles(Player, MarblesNames),
                           get_all_positions(Board, MarblesNames, Positions),
                           \+check_all_moves(Board, Positions).

% game_cycle(+GameMode:atom, +Board-Player:pair(list(list(atom)), atom)) 
% Main game loop for the different game modes.
% The game mode is an atom and the board and current player are represented as a pair (list of lists of atoms and atom).
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

