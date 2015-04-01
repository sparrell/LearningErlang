%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File      : ring.erl
%%% Author    : Duncan Sparrell duncan@sfractal.com
%%% Copyright : 2015 Duncan Sparrell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-module(mysum_tests).

-include_lib("eunit/include/eunit.hrl").


-ifdef(TEST).

% tests of erlang to make sure tests running (did these first)
reverse_nil_test() -> [] = lists:reverse([]).
reverse_one_test() -> [1] = lists:reverse([1]).
reverse_two_test() -> [2,1] = lists:reverse([1,2]).

%simple tests of sum function
sum_0_test() -> 0 = mysum:sum(0).
sum_1_test() -> 1 = mysum:sum(1).
sum_2_test() -> 3 = mysum:sum(2).
sum_3_test() -> 6 = mysum:sum(3).
sum_4_test() -> 10 = mysum:sum(4).
%learn how to do negative tests (ie catch expected exceptions)
sum_neg_test() -> ?assertError(function_clause, mysum:sum(-1)).

-endif.

