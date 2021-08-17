% Enunciado: https://docs.google.com/document/d/1RNgFMlSqOKiwe9SEi1U2cQjCmdFfWNflqycSfp7Qa-w/edit#heading=h.8z5fk89ui0rg

% 1) --------------------------------------------------------------
% turnoAtender/4(Persona,Dia,HorarioInicial,HorarioFinal).

turnoAtender(dodain,lunes,9,15).
turnoAtender(dodain,miercoles,9,15).
turnoAtender(dodain,viernes,9,15).
turnoAtender(lucas,martes,10,20).
turnoAtender(juanC,sabado,18,22).
turnoAtender(juanC,domingo,18,22).
turnoAtender(juanFdS,jueves,10,20).
turnoAtender(juanFdS,viernes,12,20).
turnoAtender(leoC,lunes,14,18).
turnoAtender(leoC,miercoles,14,18).
turnoAtender(martu,miercoles,23,24).
turnoAtender(vale,Dia,HorarioInicial,HorarioFinal):-
    turnoAtender(dodain,Dia,HorarioInicial,HorarioFinal).
turnoAtender(vale,Dia,HorarioInicial,HorarioFinal):-
    turnoAtender(juanC,Dia,HorarioInicial,HorarioFinal).

% 2) --------------------------------------------------------------
% atiende/3(Persona,Dia,Hora).

atiende(Persona,Dia,Hora):-
    turnoAtender(Persona,Dia,HoraInicial,HoraFinal),
    between(HoraInicial, HoraFinal, Hora).

% 3) --------------------------------------------------------------
% foreverAlone/3(Persona,Dia,Hora)

foreverAlone(Persona,Dia,Hora):-
    atiende(Persona,Dia,Hora),
    not(atiendenAlMismoTiempo(Persona,_,Dia,Hora)).

atiendenAlMismoTiempo(Persona,OtraPersona,Dia,Hora):-
    atiende(Persona,Dia,Hora),
    atiende(OtraPersona,Dia,Hora),
    OtraPersona \= Persona.

atiendenAlMismoTiempo(Persona,OtraPersona,Dia,Hora):-
    atiende(Persona,Dia,Hora),
    atiende(OtraPersonaMas,Dia,Hora),
    OtraPersona \= OtraPersonaMas,
    atiendenAlMismoTiempo(OtraPersonaMas,OtraPersona,Dia,Hora).

% 4) --------------------------------------------------------------
% posibilidadDeAtencion/2(ListaPersona/s,Dia). -> Recursividad?

posibilidadDeAtencion(Personas,Dia):-
    atiende(Persona,Dia,_),
    findall(OtraPersona,atiendenAlMismoTiempo(OtraPersona,Persona,Dia,_),ListaDuplas),
    list_to_set(ListaDuplas, Personas).

% 5) --------------------------------------------------------------
% vendio/3(Persona,Fecha,Productos).
% golosinas(Precio), cigarrillos(Marcas), bebidas(Cant, Tipo)

vendio(dodain,10,[golosinas(1200),cigarrillos([jockey]),golosinas(50)]).
vendio(dodain,12,[bebidas(8,alc),bebidas(1,noAlc),golosinas(10)]).
vendio(martu,12,[golosinas(1000),cigarrillos([chesterfield,colorado,parisiennes])]).
vendio(lucas,11,[golosinas(600)]).
vendio(lucas,18,[bebidas(2,noAlc),cigarrillos([derby])]).

esSuertuda(Persona):-
    vendio(Persona,_,_),
    forall(vendio(Persona,Dia,_),
        primeraVentaImportante(Persona,Dia)).

primeraVentaImportante(Persona,Dia):-
    vendio(Persona,Dia,Productos),
    nth1(1,Productos,PrimeraVenta),
    ventaImportante(PrimeraVenta).

ventaImportante(golosinas(Cantidad)):- Cantidad > 100.

ventaImportante(cigarrillos(Marcas)):- 
    length(Marcas, Cantidad),
    Cantidad > 2.

ventaImportante(bebidas(_,alc)).

ventaImportante(bebidas(Cantidad,noAlc)):- Cantidad > 5.


