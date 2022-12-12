print_line([]):- nl.
print_line([block|Rest]):- write('      '),
                           print_line(Rest).

print_line([empty|Rest]):- write(empty),
                           write('    '),
                           print_line(Rest).
                           
print_line([First|Rest]):- write(First),
                           put_char(' '),
                           print_line(Rest).

print_board([]):-nl.
print_board([FirstLine|Rest]):- print_line(FirstLine),
                                print_board(Rest).

retrieve_command(Marble, Line-Column):- write('Which marble you want to move? '),
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
