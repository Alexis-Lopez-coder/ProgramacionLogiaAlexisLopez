%	Gramatica
%
%	<expr> ::= <op> <numero> <numero>
%	<op> ::= '-' | '+' | '/' | '*'
%	<numero> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
%
%	ejemplo
%	+ 1 2
%
%	Defina en prolog un predicado que permita validar la gramatica
%	Anterior
%
%	expr("+",1,2).
%	true.
%
%	expr("+",11,2). % falso por que esta limitado a un solo numero
%	false.
%
%	expr("/",10,5).
%	false.
%
%	expr("+","*",2).
%	false.
%
%	Hay un predicado en prolog que te verifica si un atomo es un numero
%	number(2).
%	true.
%
%	number('+').
%	false


simbolo("-").
simbolo("+").
simbolo("/").
simbolo("*").


digito(0).
digito(1).
digito(2).
digito(3).
digito(4).
digito(5).
digito(6).
digito(7).
digito(8).
digito(9).


operador(A) :- simbolo(A).
numero(B)   :- digito(B).

expr(A,B,C) :- operador(A), numero(B), numero(C).