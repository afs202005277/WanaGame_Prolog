% define the board size
size(5).

% define the starting positions for each players marbles
player(1, [1-1, 1-2, 1-3, 2-1, 2-2, 2-3, 3-1, 3-2]).
player(2, [3-3, 3-4, 3-5, 4-3, 4-4, 4-5, 5-3, 5-4]).

% define the valid moves for a given position on the board
valid_move(X-Y, X-Z) :-
  size(S),
  between(1, S, X),
  between(1, S, Y),
  between(1, S, Z),
  Y \= Z.

% define the move that wraps around the board
wrap_move(X-Y, X-Z) :-
  size(S),
  between(1, S, X),
  (Y =:= 1, Z is S) ; (Y =:= S, Z is 1).

% define the rules for moving a marble
move(X-Y, X-Z) :-
  valid_move(X-Y, X-Z),
  \+ occupied(X-Z).
move(X-Y, X-Z) :-
  wrap_move(X-Y, X-Z),
  \+ occupied(X-Z).

% check if a given position on the board is occupied by a marble
occupied(X-Y) :-
  player(P, Marbles),
  member(X-Y, Marbles).

% define the game loop
play :-
  current_player(P),
  player(P, Marbles),
  write('Player '), write(P), write(' turn. Marbles at: '), write(Marbles), nl,
  select_move(X-Y, X-Z),
  move(X-Y, X-Z),
  retract(player(P, Marbles)),
  delete(Marbles, X-Y, NewMarbles),
  append(NewMarbles, [X-Z], UpdatedMarbles),
  assert(player(P, UpdatedMar