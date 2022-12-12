print_line([]):- nl.
print_line([block|Rest]):- write('\t\t'),
                           print_line(Rest).

print_line([empty|Rest]):- write(empty),
                           write('       \t'),
                           print_line(Rest).
                           
print_line([First|Rest]):- write(First),
                           write('   '),
                           put_char('\t'),
                           print_line(Rest).

print_board([]):-nl.
print_board([FirstLine|Rest]):- print_line(FirstLine),
                                put_char('\n'),
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
