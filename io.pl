print_line([]):- nl.
print_line([block|Rest]):- print_formatted('     ', 11),
                           print_line(Rest).
                           
print_line([First|Rest]):- print_formatted(First, 11),
                           print_line(Rest).

display_game([], _):-nl.
display_game([FirstLine|Rest], LineIndex):- append([LineIndex], FirstLine, Tmp),
                                           append(Tmp, [LineIndex], Res),
                                           print_line(Res),
                                           nl,
                                           NewIdx is LineIndex+1,
                                           display_game(Rest, NewIdx).

display_game(Board):- size(Size),
                     Max is Size-1,
                     numlist(0, Max, L),
                     append([' '], L, Indexes),
                     print_line(Indexes),
                     display_game(Board, 0),
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

check_marble_id(Marble):- Marble > 0, Marble < 9, peek_char('\n'), get_char('\n').
check_marble_id(_):- write('Invalid marble! Your choice must be between 1 and 8, including.\n'), clear_input, fail.

check_separator:- get_char('-').
check_separator:- write('The coordinates input must be in the format "LineIndex-ColumnIndex".\nFurthermore, each coordinate must be between 0 and 8, including.\n'), !, clear_input, fail.

retrieve_command(Player, Marble, Line-Column):- write(Player), write(' it is your turn!'),
                                                nl,
                         write('Which marble you want to move? '),
                         read_number(Marble),
                         check_marble_id(Marble),
                         write('Where do you want to move it? [Line-Column] '),
                         read_number(Line),!,
                         check_separator,
                         read_number(Column),
                         get_code(10).

check_option(Option, GameMode):- gamemode(Option, GameMode).
check_option(_, _):-  write('Invalid Option! Your choice must be one of 1, 2, 3 or 4: '), fail.

check_option_ai_level(Option, Level):- ai_level(Option, Level).
check_option_ai_level(_, _):- write('Invalid Option! Your choice must be one of 1 or 2: '), fail.

start_menu(GameMode):- write('Greetings! This is our implementation of the Wana game.\n'),
                         write('We offer you different game modes, namely:\n'),
                         write('1- Multiplayer mode (human vs human)\n'),
                         write('2- Human vs Computer\n'),
                         write('3- Computer vs Human\n'),
                         write('4- Computer vs Computer\n\n'),
                         write('Please choose a game mode: '),
                         repeat,
                         read_number(Option),
                         get_code(10),
                         check_option(Option, GameMode).

set_ai_level(Level):- write('In our game you can choose one of 2 levels:\n'),
                 write('1- Easy\n'),
                 write('2- Hard\n'),
                 write('Pease select one of the levels: '),
                 repeat,
                 read_number(Option),
                 get_code(10),
                 check_option_ai_level(Option, Level).



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