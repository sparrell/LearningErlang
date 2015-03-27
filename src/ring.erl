%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File      : ring.erl
%%% Author    : Duncan Sparrell
%%% Copyright : 2015 Duncan Sparrell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-module(ring).

%% API functions
-export( [ start/2, stop/0 ] ).

%% remote execution functions
-export( [ listen/1 ] ).

start(N, M) when ( (N > 0) and (M > 0) )->
	io:format("init N=~p and M=~p~n", [N,M] ),
	%% make a list of the sequence of nodes to send messages (ie pidlist duplicated N times)
	%% start N nodes keeping pids in sorted list
	%% duplicate list N times
	%% flatten list

	PidList = lists:flatten( lists:duplicate(N, lists:sort( [ spawn( ring, listen, [Num] ) || Num <- lists:seq(1,N) ] ) ) ),
	io:format("PidList = ~p~n", [PidList] ),

	%send message to first node with with list of rest to send 
	sendOn(PidList),
	
	io:format("master = ~p is finishing~n", [self()] ).

sendOn( [ SendTo | Rest ] ) ->
	SendTo ! { pingList, Rest }.
	

stop() ->
	echo_svr_pid ! stop.

listen(IamNode) ->
	receive
		{ pingList, [] } ->
			% empty pidcache so this is end of line, quietly die by not recursing
			io:format("got to pingList on ~p,~p and ending~n", [IamNode,self()]);
		{ pingList, PidCache } ->
			% send message on
			sendOn( PidCache ),
			io:format("got to pingList on ~p,~p~n", [IamNode,self()]),
			% decide if this node needs to continue by if it's node is in PidCache
			case lists:member( self(), PidCache ) of
				true -> listen(IamNode);
				false -> io:format("I'm done ~p,~p~n", [IamNode,self()])
			end;
		{ print, Msg } ->
			io:format("~p~n", [Msg] ),
			listen(IamNode);
		stop  ->
			io:format("master = ~p is finishing~n", [self()] )
	end.
