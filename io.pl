print_line([]):- nl.
print_line([block|Rest]):- print_formatted('     ', 11),
                           print_line(Rest).
                           
print_line([First|Rest]):- print_formatted(First, 11),
                           print_line(Rest).

print_board([], _):-nl.
print_board([FirstLine|Rest], LineIndex):- append([LineIndex], FirstLine, Tmp),
                                           append(Tmp, [LineIndex], Res),
                                           print_line(Res),
                                           nl,
                                           NewIdx is LineIndex+1,
                                           print_board(Rest, NewIdx).

print_board(Board):- size(Size),
                     Max is Size-1,
                     numlist(0, Max, L),
                     append([' '], L, Indexes),
                     print_line(Indexes),
                     print_board(Board, 0),
                     print_line(Indexes).

print_n(_, 0).
print_n(S, N):- N>0,
                write(S),
                N1 is N-1,
                print_n(S, N1).

print_text(TextAtom, Padding):- print_n(' ', Padding),
                                write(TextAtom),
                                print_n(' ', Padding).

print_formatted(Content, TargetSize):- \+atom(Content),
                            number_codes(Content, Codes),
                            atom_codes(Atom, Codes),
                            print_formatted(Atom, TargetSize).

print_formatted(Content, TargetSize):- atom_length(Content, ContentLength),
                                         Remaining is (TargetSize-ContentLength)//2,
                                         Remaining >= 0,
                                         print_text(Content, Remaining).


retrieve_command(Player, Marble, Line-Column):- write(Player), write(' it is your turn!'),
                                                nl,
                         write('Which marble you want to move? '),
                         read_number(Marble),
                         get_code(10),
                         write('Where do you want to move it? [Line-Column] '),
                         read_number(Line),
                         get_char('-'),
                         read_number(Column),
                         get_code(10).

start_menu(GameMode):- write('Greetings! This is our implementation of the Wana game.\n'),
                         write('We offer you different game modes, namely:\n'),
                         write('1- Multiplayer mode (human vs human)\n'),
                         write('2- Human vs Computer\n'),
                         write('3- Computer vs Computer\n\n'),
                         write('Please choose a game mode: '),
                         repeat,
                         read_number(Option),
                         get_code(10),
                         (\+gamemode(Option, GameMode) -> write('Invalid Option! Your choice must be one of 1, 2 or 3: '), fail; \+fail).

% https://textkool.com/en/ascii-art-generator?hl=default&vl=default&font=Big&text=Player%201%20Won%20%20%20!!
congratulate(player1):- write('  _____  _                         __  __          __             _ _ '),nl,
                     write(' |  __ \\| |                       /_ | \\ \\        / /            | | |'),nl,
                     write(' | |__) | | __ _ _   _  ___ _ __   | |  \\ \\  /\\  / /__  _ __     | | |'),nl,
                     write(' |  ___/| |/ _` | | | |/ _ \\ \'__|  | |   \\ \\/  \\/ / _ \\| \'_ \\    | | |'),nl,
                     write(' | |    | | (_| | |_| |  __/ |     | |    \\  /\\  / (_) | | | |   |_|_|'),nl,
                     write(' |_|    |_|\\__,_|\\__, |\\___|_|     |_|     \\/  \\/ \\___/|_| |_|   (_|_)'),nl,
                     write('                  __/ |                                               '),nl,
                     write('                 |___/                                                '),nl.

congratulate(player2):- write('  _____  _                         ___   __          __             _ _ '),nl,
write(' |  __ \\| |                       |__ \\  \\ \\        / /            | | |'),nl,
write(' | |__) | | __ _ _   _  ___ _ __     ) |  \\ \\  /\\  / /__  _ __     | | |'),nl,
write(' |  ___/| |/ _` | | | |/ _ \\ \'__|   / /    \\ \\/  \\/ / _ \\| \'_ \\    | | |'),nl,
write(' | |    | | (_| | |_| |  __/ |     / /_     \\  /\\  / (_) | | | |   |_|_|'),nl,
write(' |_|    |_|\\__,_|\\__, |\\___|_|    |____|     \\/  \\/ \\___/|_| |_|   (_|_)'),nl,
write('                  __/ |                                                 '),nl,
write('                 |___/                                                  '),nl.