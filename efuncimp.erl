-module(efuncimp).

-export([map/2, flatten/1, sum/1, filter/2, reduce/3, quick_sort/1]).

-spec map(fun((A) -> B), list(A)) -> list(B);
         (_, []) -> [].
	 
-spec filter(fun((A) -> boolean()), list(A)) -> list(A).

-spec reduce(any(), fun((any(), A) -> any()), list(A)) -> any().

%
%Reduce implementation
%

reduce(Acc, Fn, [Head | Tail]) ->
  reduce(Fn(Acc, Head), Fn, Tail);
reduce(Acc, _, []) ->
  Acc. 

%
%Map implementation
%

map(Fn, [Head | Tail]) ->
  [Fn(Head) | map(Fn, Tail)];
map(_, []) ->
  [].

%
%Filter implementation
%

filter(Fn, [Head | Tail]) ->
  filter(Fn, Head) ++ filter(Fn, Tail);
filter(_, []) ->
  [];
filter(Fn, Value) ->
  case Fn(Value) of 
    true -> [Value];
    false -> []
  end.

%
%Flatten implementation
%

flatten([Head | Tail]) ->
  flatten(Head) ++ flatten(Tail);
flatten([]) ->
  [];
flatten(Value) ->
  [Value].

%
%QuickSort implementation
%

quick_sort([]) ->
  [];
quick_sort([Head | []]) ->
      [Head];
quick_sort([Head | [Tail | []]]) ->
    case Head > Tail of
      true -> [Tail, Head];
      false -> [Head, Tail]
    end;
quick_sort([Base | Other]) ->
  {LeftArray, RightArray} = quick_sort(Base, Other, {[], []}),
quick_sort(LeftArray) ++ [Base] ++ quick_sort(RightArray).
quick_sort(Base, [Head | Tail], {LeftArray, RightArray}) ->
  case Base > Head of
    true -> quick_sort(Base, Tail, {[Head] ++ LeftArray, RightArray});
    false -> quick_sort(Base, Tail,  {LeftArray, [Head] ++ RightArray})
  end;
quick_sort(_, [], Arrays) -> 
  Arrays.

%
%Sum implementation
%

sum(List) ->
  sum(List, 0).

sum([Head | Tail], Sum) ->
  sum(Tail, Head + Sum);
sum([], Sum) ->
  Sum.

