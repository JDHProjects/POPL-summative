% QUESTION 1

% stations assigned in alphabetical order
station('AL',['metropolitan']).
station('BG',['central']).
station('BR',['victoria']).
station('BS',['metropolitan']).
station('CL',['central']).
station('EC',['bakerloo']).
station('EM',['bakerloo','northern']).
station('EU',['northern']).
station('FP',['victoria']).
station('FR',['metropolitan']).
station('KE',['northern']).
station('KX',['metropolitan','victoria']).
station('LG',['central']).
station('LS',['central','metropolitan']).
station('NH',['central']).
station('OC',['bakerloo','central','victoria']).
station('PA',['bakerloo']).
station('TC',['central','northern']).
station('VI',['victoria']).
station('WA',['bakerloo']).
station('WS',['northern','victoria']).


% QUESTION 2

station_exists(Station) :-
    station(Station,_).                                                 % _ used as we do not care about line, only that the station exists

% test cases:

% station_exists('WA').
% true.

% station_exists('A').
% false.


% QUESTION 3

% Bakerloo line
adjacent('WA','PA').
adjacent('PA','WA').
adjacent('PA','OC').
adjacent('OC','PA').
adjacent('OC','EM').
adjacent('EM','OC').
adjacent('EM','EC').
adjacent('EC','EM').

% Central line
adjacent('NH','LG').
adjacent('LG','NH').
adjacent('LG','OC').
adjacent('OC','LG').
adjacent('OC','TC').
adjacent('TC','OC').
adjacent('TC','CL').
adjacent('CL','TC').
adjacent('CL','LS').
adjacent('LS','CL').
adjacent('LS','BG').
adjacent('BG','LS').

% Victoria line
adjacent('BR','VI').
adjacent('VI','BR').
adjacent('VI','OC').
adjacent('OC','VI').
adjacent('OC','WS').
adjacent('WS','OC').
adjacent('WS','KX').
adjacent('KX','WS').
adjacent('KX','FP').
adjacent('FP','KS').

% Metropolitan line
adjacent('FR','BS').
adjacent('BS','FR').
adjacent('BS','KX').
adjacent('KX','BS').
adjacent('KX','LS').
adjacent('LS','KS').
adjacent('LS','AL').
adjacent('AL','LS').

% Northern line
adjacent('EU','WS').
adjacent('WS','EU').
adjacent('WS','TC').
adjacent('TC','WS').
adjacent('TC','EM').
adjacent('EM','TC').
adjacent('EM','KE').
adjacent('KE','EM').


% QUESTION 4

sameline(Station1,Station2,Line) :-
    station(Station1,Station1LineList),                                 % get list of lines connected to Station1
    member(Line,Station1LineList),                                      % true if Line is in list of lines connected to Station1, false otherwise
    station(Station2,Station2LineList),                                 % get list of lines connected to Station2
    member(Line,Station2LineList).                                      % true if line is in list of lines connected to Station2, false otherwise

% test cases:

% sameline('WA','EC',Line).
% Line = 'Bakerloo'.

% sameline('FP','KE',Line).
% false.


% QUESTION 5

line(Line,ListOfStations) :-
    findall(X, sameline(X, X, Line), ListOfStations).                   % uses findall to find every query answer to the query
                                                                        % sameline is used to check line valid for a specific station by making both its station args the same station

% test cases:
% line('metropolitan',ListOfStations).
% ListOfStations = ['AL', 'BS', 'FR', 'KX', 'LS'].

% line('victoria',ListOfStations).
% ListOfStations = ['BR', 'FP', 'KX', 'OC', 'VI', 'WS'].


% QUESTION 6

station_numlines(Station,NumberOfLines) :-
    station(Station,X),                                                 % get lines list for specified station
    length(X, NumberOfLines).                                           % set NumberOfLines to the length of the lines list

% test cases:

% station_numlines('AL',NumberOfLines).
% NumberOfLines = 1.

% station_numlines('OC',NumberOfLines).
% NumberOfLines = 3.

% station_numlines('A',NumberOfLines).
% false.


% QUESTION 7

adjacent2interchange(NonInterStation, InterchangeStation) :-
    station_numlines(NonInterStation, 1),                               % check if first station is not an interchange station (line count equals 1)
    adjacent(NonInterStation , InterchangeStation),                     % check if the two stations are adjacent
    station_numlines(InterchangeStation, Y),                            % check if second station is an interchange station (line count > 1)
    Y > 1.

% test cases:

% adjacent2interchange('OC',InterchangeStation).
% false.

% adjacent2interchange('CL',InterchangeStation).
% InterchangeStation = 'TC' ;
% InterchangeStation = 'LS'.


% QUESTION 8

route(From, To, Route) :-
    routeCalc(From, To, [], RouteRecurse),                              % start recursion
    reverse([To|RouteRecurse],Route).                                   % once recursion is done, append target station to head of recursion output list, then reverse list

routeCalc(From, To, TempRoute, Route) :-                                % recursion base case
    adjacent(From, To),                                                 % check if current station is adjacent to target station
    not(member(From,TempRoute)),                                        % check if current station is already part of route (false if it is)
    Route=[From|TempRoute].                                             % append current station to head of temp route list

routeCalc(From, To, TempRoute, Route) :-                                % recursion recursive case
    adjacent(From, NextStation),                                        % get a station adjacent to current station (next station)
    not(NextStation==To),                                               % check next station is not the target station
    not(member(From,TempRoute)),                                        % check if current station is already part of route (false if it is)
    routeCalc(NextStation,To,[From|TempRoute],Route).                   % call self again with:
                                                                            %current station set to next station
                                                                            %current station appended to head of temp route list
                                                                            %other values the same

% test cases:

% route('TC','CL',Route).
% Route = ['TC', 'CL'] ;
% Route = ['TC', 'OC', 'WS', 'KX', 'LS', 'CL'] ;
% Route = ['TC', 'WS', 'KX', 'LS', 'CL'] ;
% Route = ['TC', 'EM', 'OC', 'WS', 'KX', 'LS', 'CL'] ;
% false.

% route('TC','A',Route).
% false.


% QUESTION 9

route_time(From,To,Route,Minutes) :-
    route(From, To, Route),                                             % get route between stations
    length(Route, RouteLength),                                         % get length of route list
    Minutes is (RouteLength-1) * 4.                                     % minus 1 from length of route list, then multiply by 4

% test cases:

% route_time('FR','OC',Route,Minutes).
% Route = ['FR', 'BS', 'KX', 'WS', 'OC'],
% Minutes = 16 ;
% Route = ['FR', 'BS', 'KX', 'WS', 'TC', 'OC'],
% Minutes = 20 ;
% Route = ['FR', 'BS', 'KX', 'WS', 'TC', 'EM', 'OC'],
% Minutes = 24 ;
% Route = ['FR', 'BS', 'KX', 'LS', 'CL', 'TC', 'OC'],
% Minutes = 24 ;
% Route = ['FR', 'BS', 'KX', 'LS', 'CL', 'TC', 'WS', 'OC'],
% Minutes = 28 ;
% Route = ['FR', 'BS', 'KX', 'LS', 'CL', 'TC', 'EM', 'OC'],
% Minutes = 28 ;
% false.

% route_time('FR','A',Route,Minutes).
% false.

