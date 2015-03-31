-module(learningErlang_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    learningErlang_sup:start_link().

stop(_State) ->
    ok.

%% -ifdef(TEST).
%%
%% simple_test() ->
%%     ok = application:start(learningErlang),
%%     ?assertNot(undefined == whereis(learning_sup)).
%%
%% -endif.