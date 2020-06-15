latom_lstring([],[]).
latom_lstring([F|C],R) :- latom_lstring(C,S), atom_string(F,SF), append([SF],S,R).


preparar_string(Term,LS) :-
    atom(Term),
    atom_string(Term,Str),
    preparar_string(Str,LS).

preparar_string(Str,LS) :-
    string(Str),
    string_chars(Str,LAC),
    latom_lstring(LAC,LS).
 

digito(N) :- N == "0".
digito(N) :- N == "1".
digito(N) :- N == "2".
digito(N) :- N == "3".
digito(N) :- N == "4".
digito(N) :- N == "5".
digito(N) :- N == "6".
digito(N) :- N == "7".
digito(N) :- N == "8".
digito(N) :- N == "9".


digitos([F|[]]) :- digito(F).
digitos([F|C]) :- digito(F), digitos(C).


% Desarrolle un predicado que permita validar un NIP de una banco que 
% Responde a la siguiente gramatica
% Nip ::= <Digito> ' ' <Digito> ' ' <Digito> ' ' <Digito>
% Digito ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

nip(L) :- string_length(L,N), N == 4, preparar_string(L,R), digitos(R).


% Desarrolle un predicado que permita validar un octeto de una ip
% Responde a la siguiente gramatica
% Octeto ::= '2'<R5><R5> | '1'<Digito><Digito> | <Digito><Digito> | <Digito>
% R5 ::= 0 | 1 | 2 | 3 | 4 | 5
% Digito ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

validar([F|C],"2"):- r52([F|C]).

validar([F|C],"1") :- digitos([F|C]).


r5(X) :- X == "0"; X == "1"; X == "2"; X == "3"; X == "4"; X == "5".

r52([F|C]) :- r5(F), r52(C).

r52([F|[]]) :- r5(F).


octeto(L) :- preparar_string(L,R), string_length(L,3), [P|O] = R, validar(R,P).
octeto(L) :- preparar_string(L,R), string_length(L,2), digitos(R).
octeto(L) :- preparar_string(L,R), string_length(L,1), digitos(R).