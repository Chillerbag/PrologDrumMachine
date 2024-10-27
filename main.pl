:- use_module(input_handler).

clear_terminal :-
    write('\e[H\e[2J'),
    flush_output.

print_cell(Item, CurrentPos, Pos) :-
    (CurrentPos = Pos ->
        write('[ *'), write(Item), write(']')
    ;
        write('[ '), write(Item), write(' ]')
    ),
    flush_output.

print_list(List, CurrentPos) :-
    clear_terminal,
    length(List, Len),
    print_list(List, CurrentPos, 0, Len),
    flush_output.

print_list([], _, _, _).
print_list([H|T], CurrentPos, Pos, Len) :-
    print_cell(H, CurrentPos, Pos),
    write(' '),
    NextPos is Pos + 1,
    print_list(T, CurrentPos, NextPos, Len).

animate_list(List) :-
    animate_list(List, 0).

animate_list(List, CurrentPos) :-
    length(List, Len),
    print_list(List, CurrentPos),
    input_handler(1, CurrentPos, List, NewList),
    NextPos is (CurrentPos + 1) mod Len,
    sleep(0.5),
    animate_list(NewList, NextPos).

% whats next? 
% - we need to read the list in the main loop and have audio handler player responding 
% this probably isnt a drum machine anymore now that we're doing midi sounds lol. 
% maybe like prolog ringtone studio or something ahah
% maybe down the way i can figure out a way to export the list into an actual midi file. 


main :-
    animate_list(['_', '_', '_', '_', '_', '_', '_', '_']).