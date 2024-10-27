:- module(input_handler, [
    input_handler/4
]).

input_handler(0, _, List, List).
input_handler(N, CurrentPos, List, FinalList) :-
    N > 0,
    (check_input(Char) ->
        handle_user_input(Char, CurrentPos, List, NewList),
        N1 is N - 1,
        input_handler(N1, CurrentPos, NewList, FinalList)
    ;   
        N1 is N - 1,
        input_handler(N1, CurrentPos, List, FinalList)
    ).

% ok this sort of works. It seems to skip on input, and requires user to hit enter
% maybe there is some sort of buffer i need to clear ? or maybe key + enter contains
% more data than im aware so its just reading first char a couple times. 
% but why would n not decrement properly? odd. 
check_input(Char) :-
    current_input(Stream),
    wait_for_input([Stream], Waiting, 1),
    (member(Stream, Waiting) -> 
        get_single_char(Char)
    ;
        fail
    ).

update_current_pos([_|T], 0, Char, [Char|T]).
update_current_pos([H|T], I, Char, [H|R]) :-
    I > 0,
    I2 is I - 1,
    update_current_pos(T, I2, Char, R).

handle_user_input(107, CurrentPos, List, NewList) :-  % kick ? 
    update_current_pos(List, CurrentPos, 'k', NewList).
handle_user_input(104, CurrentPos, List, NewList) :- 
    update_current_pos(List, CurrentPos, 'h', NewList). % high hat ? 
handle_user_input(100, CurrentPos, List, NewList) :- 
    update_current_pos(List, CurrentPos, 'd', NewList). % drum ? 
handle_user_input(_, _, List, List). 
