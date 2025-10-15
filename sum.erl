-module(sum).
-export([sum/1]).

sum([]) -> 0;
sum([H|T]) -> sum(T) + H. 
% sum(Array) -> 
%     [H|T] = Array,
%     H + sum(T). 