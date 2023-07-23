/*
Pattern maching

is debe tener si o sí el valor N.

functor de aridad 3  fecha(22,08,1979) || nacio(karla, fecha(22, 08, 1979)). 

Un functor
no es un predicado, si bien tienen formatos similares el functor no tiene un valor de verdad, no puedo preguntar ?- fecha(22, 08, 1979)
tiene un nombre y una aridad que es la cantidad de individuos que lo componen
corolario: denota un individuo compuesto
dos functores con distinta aridad representan dos abstracciones diferentes
es equivalente a la tupla de Funcional, pero el nombre o prefijo permite entender más claramente el origen de los individuos que participan del functor (le da mayor expresividad)
es especialmente útil cuando necesitamos trabajar elementos heterogéneos, que tienen algo común pero diferente información entre sí
puede relacionar átomos, otros functores o listas

Lo que no se puede es tratar de relacionar como variable el nombre del functor:


*/


puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).
puntajes(eeh,[7,7,7,7]).


puntajeSalto(Nombre,Posicion,Nota) :- puntajes(Nombre,ListaPuntajes), nth1(Posicion,ListaPuntajes,Elemento), Nota is Elemento.
estaDescalificado(Nombre) :- puntajes(Nombre,ListaPuntajes), length(ListaPuntajes,CantidadPuntajes), CantidadPuntajes>5.
clasificaALaFinal(Nombre) :- not(estaDescalificado(Nombre)), puntajes(Nombre,ListaPuntajes), sumlist(ListaPuntajes,Numero), Numero>= 28.
clasificaALaFinal(Nombre) :- not(estaDescalificado(Nombre)), puntajes(Nombre,ListaPuntajes), sonBuenosPuntajes(ListaPuntajes).
sonBuenosPuntajes(ListaPuntajes):-intersection(ListaPuntajes,[8,9,10], NuevaLista), length(NuevaLista, CantidadPuntajes), CantidadPuntajes >=2.