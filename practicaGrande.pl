% Desarrollo una gramatica bnf (como la del video) para validar una 
% direccion ipv4 asi como una mascara de red.
% https://es.wikipedia.org/wiki/M%C3%A1scara_de_red#Tabla_de_m%C3%A1scaras_de_red
% Realice la implementacion de dicha gramatica en prolog donde
% se pueda validar la cadena donde esta esa ip o mascara ejemplo

% ip("192.168.1.1").
% true.
% ip("256.168.1.1").
% false.
% maskR("255.255.255.0").
% true.
% maskR("255.255.255.1").
% false.
 
octeto("0").
octeto("128").
octeto("192").
octeto("224").
octeto("240").
octeto("248").
octeto("252").
octeto("254").
octeto("255").

octetos([F|[]]):- octeto(F).
octetos([F|C]) :- octeto(F), octetos(C).


maskR(Z) :-
    split_string(Z,".","",M),
    length(M,L2),
    L2 == 4,
    [F|C] = M,
    octeto(F),
    primerOcteto(C,F).

primerOcteto(C,"255") :-
    octetos(C).

primerOcteto(C,"254") :- verCeros(C).
primerOcteto(C,"252") :- verCeros(C).
primerOcteto(C,"248") :- verCeros(C).
primerOcteto(C,"240") :- verCeros(C).
primerOcteto(C,"224") :- verCeros(C).
primerOcteto(C,"192") :- verCeros(C).
primerOcteto(C,"128") :- verCeros(C).

verCeros([F|[]]) :-
    F == "0".

verCeros([F|C]) :-
    F == "0",
    verCeros(C).




% split_string("255.254.128.0",".","",M),length(M,L2), L2 == 4, [F|C] = M, octeto(F), F == "255", octetos(C).







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

numeros([F|C]) :- digito(F), numeros(C).
numeros([F|[]]) :- digito(F).

primerDigito("1").
primerDigito("2").

r5(X) :- X == "0".
r5(X) :- X == "1".
r5(X) :- X == "2".
r5(X) :- X == "3".
r5(X) :- X == "4".
r5(X) :- X == "5".

r52([F|[]]):- r5(F).
r52([F|C]) :- r5(F), r52(C).

ip(L) :- 
    split_string(L,".","",IP),
    length(IP, L1), L1 == 4,
    
    [F|C] = IP,
    string_length(F,R),
    long_cadena([F|C],R),

    [F2 | C2] = C,
    string_length(F2,R2),
    long_cadena([F2|C2],R2),

    [F3 | C3] = C2,
    string_length(F3,R3),
    long_cadena([F3|C3],R3),

    [F4 | C4] = C3,
    string_length(F4,R4),
    long_cadena([F4|C4],R4).
    
    

long_cadena([F|C],3) :- 
    preparar_string(F,[F1|C2]), 
    primerDigito(F1),
    definir(C2,F1).
    

definir(K, "1") :-
    numeros(K).
    

definir(K, "2") :-
    r52(K).


long_cadena([F|C],2) :- 
    preparar_string(F,[F1|C2]),
    digito(F1),
    numeros(C2).

long_cadena([F|C],1) :- 
    preparar_string(F,[F1|C2]),
    digito(F1).
