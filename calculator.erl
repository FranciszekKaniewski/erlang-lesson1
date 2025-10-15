-module(calculator).
-export([add/2,sub/2,multi/2,divi/2]).

add(A,B) -> A + B.
sub(A,B) -> A - B.
multi(A,B) -> A * B.
divi(A,B) -> A/B.