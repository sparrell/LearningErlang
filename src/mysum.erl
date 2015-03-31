-module(mysum).
-export( [ sum/1,sum_interval/2, create/1, reverse_create/1, print/1, even_print/1 ] ).

sum(N) when N > 0 -> sum(N, 0);
sum(0) -> 0.

sum(0, SumAccumulator) -> SumAccumulator;
sum(N, SumAccumulator) ->
	sum(N-1,N + SumAccumulator).


sum_interval(N,M) -> sum_interval(N,M,0).

sum_interval(N,M,SumAccumulator) when N < M ->
	sum_interval(N,M-1,SumAccumulator+M);
sum_interval(N,M,SumAccumulator) when N == M ->
	SumAccumulator + M.

create(N) -> lists:seq(1,N).

reverse_create(N) -> lists:seq(N,1,-1).

print(N) ->
	printAll( lists:seq(1,N) ).

printAll( [] ) ->
	ok;
printAll( [Next | Rest ] ) ->
	io:format("~p~n", [Next] ),
	printAll(Rest).

even_print(N) ->
	even_printAll( lists:seq(1,N) ).

even_printAll( [] ) ->
	ok;
even_printAll( [Next | Rest ] ) when (Next rem 2 == 0) ->
	io:format("~p~n", [Next] ),
	even_printAll(Rest);
even_printAll( [_ | Rest ] ) ->
	even_printAll(Rest).
