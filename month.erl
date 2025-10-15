-module(month).
-export([month_length/2]).

month_length(Year, Month) -> 
    Leap = 
    if
        Year rem 400 == 0 -> 
            true;
        Year rem 100 == 0 ->
            false;
        Year rem 4 == 0 ->
            true;
        true -> 
            false
    end,

    case Month of
        1 -> 31;
        2 when Leap -> 29;
        2 -> 28;
        % 2 -> if 
        %         Leap -> 29;
        %         true -> 28
        %     end;
        3 -> 31;
        4 -> 30;
        5 -> 31;
        6 -> 30;
        7 -> 31;
        8 -> 31;
        9 -> 30;
        10 -> 31;
        11 -> 30;
        12 -> 31
    end.