print_line([]):- nl.
print_line([block|Rest]):- print_formatted('     ', 9),
                           print_line(Rest).
                           
print_line([First|Rest]):- print_formatted(First, 9),
                           print_line(Rest).

print_board([], _):-nl.
print_board([FirstLine|Rest], LineIndex):- write('\t'),
                                print_line(FirstLine),
                                write('\t'),
                                put_char('\n'),
                                NewIdx is LineIndex+1,
                                print_board(Rest, NewIdx).

print_board(Board):- size(Size),
                     Max is Size-1,
                     numlist(0, Max, L),
                     print_line(L),
                     print_board(Board, 0),
                     print_line(L).

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

congratulate(Winner):- write(Winner),
                       write(' won the game!'),
                       nl.
