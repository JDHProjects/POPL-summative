% QUESTION i

sum(Lst,Sum) :-                         % base case
    Lst = [],                           % check if list is empty
    Sum = 0.                            % set Sum to 0


sum(Lst,Sum) :-                         % recursive case
    Lst = [Head|Tail],                  % get head and tail of list
    sum(Tail,TempSum),                  % recurse with tail and return recurse Sum
    Sum is TempSum + Head.              % add recurse Sum to head, return as Sum

% test cases:

% sum([1,2,3],X).
% X = 6.

% sum([1,2,3],6).
% true.


% QUESTION iii

desc(Lst) :-                            % base case
    Lst = [_|Tail],                     % get tail of list
    Tail = [].                          % check if tail is empty


desc(Lst) :-                            % recursive case
    Lst = [Head|Tail],                  % get head and tail of list
    Tail = [TailHead|_],                % get head of tail list
    Head > TailHead,                    % compare head value to next value
    desc(Tail).                         % recurse with tail

% test cases:

% desc([5,3,2,0]).
% true.

% desc([5,3,2,0,1]).
% false.

% desc([5,3,3,0]).
% false.
