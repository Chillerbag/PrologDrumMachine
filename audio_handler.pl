% template code from prosc repo, trying to get to work. 

:- use_module(library(plosc)).
:- dynamic osc_addr/1.

init :-
	osc_mk_address(localhost,57110, A),
	assert(osc_addr(A)).

bing :-
	osc_addr(A),
	get_time(T),
	osc_send(A,'/s_new',[string('Square'),int(-1),int(0),int(1),string('freq'),float(440)],T).

:- init, bing.