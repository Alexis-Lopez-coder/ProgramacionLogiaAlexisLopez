% Escribe un analizador sintactico que pueda validar sentencias
% simples que puedan ser representadas por las siguientes gramaticas
% exp ::= "(" ' ' <operacion>' ' ")"
% operacion ::= <operador>' '<secNumeros>
% operador ::= '+' |  '-' | '*' | '/'
% secnumeros ::= <numSigno> | <numSigno> ' ' <secNumeros>
% numSigno ::= <digitos> | <signo> <digitos>
% signo ::= '+' | '-'
% digitos ::= digito | digito digitos
% digito ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

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


digitos([F|[]]):- digito(F).
digitos([F|C]) :- digito(F),digitos(C).


signo("+").
signo("-").

operador("*").
operador("/").
operador(O) :- signo(O).


numerosigno([F|C]) :- signo(F), digitos(C).
numerosigno([F|C]) :- digitos([F|C]).

secnumeros([F|[]]):-  preparar_string(F,PS), numsigno(PS).
secnumeros([F|C]):-  preparar_string(F,PS), numsigno(PS), secnumeros(C).

operacion([F|C]) :- operador(F), secnumeros(C).


abre_parentesis(["("|_]).
cierra_parentesis([_|C]) :- append(_,[")"],C).



expre([F|C]) :-
    abre_parentesis([F|_]),
    cierra_parentesis([_|C]),
    append(OP,[_],C),
    operacion(OP).


% expre("( * ").