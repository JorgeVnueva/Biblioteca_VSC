/** First Wollok example */
object harryPotter {
	const cantLectores = 10500156
	method valoracion() = cantLectores / 1000000
}

object lordOfRings{
	const cantPaginas = 450
	method valoracion() = cantPaginas / 45
}

object elPrincipito{
	const es = "clasico"
	method valoracion(){
		if(es == "clasico"){
			return 50
		}
		else{
			return 0
		}
	}
}

object latinAmerica{
	const fechaPublicacion = 2001
	method valoracion() = fechaPublicacion/3
}

object hungerGames{
	const votosPositivos = 200
	const votosNegativos = 300600
	method coeficiente()= votosPositivos - votosNegativos
	method valoracion(){
		if(self.coeficiente() < 0){
			return 0
		}
		else{
			return self.coeficiente() /100000
		}
	}
}

object andy{
	var property coleccion = new List()
	var leidos = 0
	method recuerdo(algo){
		return algo.recordar(self)
	}
	
	method olvido(algo){
		algo.olvidar(self)
	}
	
	method elMejorLibro(){
		return coleccion.max({libro => libro.valoracion()})
	}
	
	method buenosLibros(){
		return coleccion.filter({libro=>libro.valoracion()>10})
	}
	
	method promedio(){
		return coleccion.sum({libro=>libro.valoracion()})/coleccion.size() 
	}
	
	method mostrarUltimo(){
		return coleccion.last()
	}
	
	method mostrarPrimero(){
		return coleccion.first()
	}
	
	method removerUltimo(){
		coleccion.remove(self.mostrarUltimo())
	}
	
	method removerPrimero(){
		coleccion.remove(self.mostrarPrimero())
	}
	
	method leer(unLibro){
		coleccion.add(unLibro)
		leidos++
	}
}

object ultimo{
	method recordar(algo) {
		return algo.mostrarUltimo()
	}
	method olvidar(algo){
		algo.removerUltimo()
	}
}

object primero{
	method recordar(algo) {
		return algo.mostrarPrimero()
	}
	method olvidar(algo){
		algo.removerPrimero()
	}
}

