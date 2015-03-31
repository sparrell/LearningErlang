%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File      : ring.erl
%%% Author    : Duncan Sparrell duncan@sfractal.com
%%% Copyright : 2015 Duncan Sparrell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-module(mysum).
-export( [ sum/1,sum_interval/2, create/1, reverse_create/1, print/1, even_print/1 ] ).

-include_lib("eunit/include/eunit.hrl").

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


-ifdef(TEST).

reverse_nil_test() -> [] = lists:reverse([]).
reverse_one_test() -> [1] = lists:reverse([1]).
reverse_two_test() -> [2,1] = lists:reverse([1,2]).

sum_0_test() -> 0 = sum(0).
sum_1_test() -> 1 = sum(1).
sum_2_test() -> 3 = sum(2).
sum_3_test() -> 6 = sum(3).
sum_4_test() -> 10 = sum(4).

-endif.

