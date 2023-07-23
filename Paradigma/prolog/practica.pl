/* 
swipl
make. recarga el programa


l "o n" para que nos devuelva más respuestas y no sólo la primera que encuentre


Tenermos "Hechos", "Regla"
- La regla tiene un antesecente
- El hecho siempre es verdadero

Cabeza - Cuello - Cuerpo

Lo que hago abajo es definir una base de conocimientos

?- humano(Quien).
consulta existencial

?- mortal(socrates).
consulta particular

mortal(_).  -- Alguien es mortal??


Todo lo que no se puede verificar será falso --
"principio de universo cerrado"

Recordemos que
Persona comienza con mayúscula → es una variable (una incógnita)
platon comienza con minúscula → es un valor (un individuo)

El orden importa para un generador.
*/
contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(jose,omni).
trabajoEn(quico, acme).
honesto(roque).
ingeniero(ana).
ingeniero(quico).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(jose).



ambicioso(Persona) :- contador(Persona), joven(Persona).
tieneExperiencia(Persona) :- trabajoEn(Persona,_).
esProfecional(Persona):-abogado(Persona).
esProfecional(Persona):-ingeniero(Persona).
esProfecional(Persona):-contador(Persona).

puedeAndar(comercioExterior, Persona):-ambicioso(Persona).
puedeAndar(contaduria, Persona):-contador(Persona),honesto(Persona).
puedeAndar(ventas, Persona):-ambicioso(Persona),tieneExperiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos, Persona):-ingeniero(Persona),tieneExperiencia(Persona).
puedeAndar(proyectos, Persona):-abogado(Persona),joven(Persona).
puedeAndar(logistica, Persona):-esProfecional(Persona), cumpleCondicion(Persona).

cumpleCondicion(Persona):-joven(Persona).
cumpleCondicion(Persona):-trabajoEn(Persona,omni).


madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).


hermano(Persona, OtraPersona):- mismaMadre(Persona, OtraPersona),mismoPadre(Persona, OtraPersona).
mismaMadre(Persona, OtraPersona):-madre(Madre,Persona),madre(Madre,OtraPersona),Persona\=OtraPersona.
mismoPadre(Persona, OtraPersona):-padre(Padre,Persona),padre(Padre,OtraPersona),Persona\=OtraPersona.

medioHermanos(Persona, OtraPersona):-mismaMadre(Persona, OtraPersona),not(mismoPadre(Persona, OtraPersona)),Persona\=OtraPersona.
medioHermanos(Persona, OtraPersona):-mismoPadre(Persona, OtraPersona),not(mismaMadre(Persona, OtraPersona)),Persona\=OtraPersona.

hijo(Persona, Progenitor):-madre(Progenitor,Persona).
hijo(Persona, Progenitor):-padre(Progenitor,Persona).

hijoUnico(Persona):-hijo(Persona,_), not(hermano(Persona,_)).

tio(Tio, Sobrino):-cumpleCondicionTio(Tio, Sobrino).



cumpleCondicionTio(Persona, OtraPersona):-hermano(Persona,Vinculo),padre(Vinculo,OtraPersona).
cumpleCondicionTio(Persona, OtraPersona):-hermano(Persona,Vinculo),madre(Vinculo,OtraPersona).
cumpleCondicionTio(Persona, OtraPersona):-medioHermanos(Persona,Vinculo),madre(Vinculo,OtraPersona).
cumpleCondicionTio(Persona, OtraPersona):-medioHermanos(Persona,Vinculo),padre(Vinculo,OtraPersona).