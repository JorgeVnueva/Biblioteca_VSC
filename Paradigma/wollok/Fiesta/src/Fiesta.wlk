class Fiesta{
	var property fecha
	var property lugar
	const property invitados = new List()
	method esBodrio(){
		invitados.all({invitado => invitado.estaDisconforme(self)})
	}
	method mejorDisfraz() = self.invitadoConMejorDisfraz().disfraz()
	method invitadoConMejorDisfraz(){
		return invitados.max({invitado=> invitado.puntajeDisfraz(self)})
	}
}

class Invitado{
	var property disfraz
	var property edad
	var property personalidad
	
	method esSexy() = personalidad.esSexy(self)
	method estaDisconforme(unaFiesta) = !self.estaConforme(unaFiesta)
	method estaConforme(unaFiesta) = disfraz.puntaje(unaFiesta,self) > 10 && self.cumpleCondiciones(unaFiesta)
	method cumpleCondiciones(_)
	method puntajeDisfraz(fiesta) = disfraz.puntaje(fiesta, self)
}

class Disfraz{
	var property nombre
	var property fechaDeFabricacion
	const property caracteristicas = []
	
	method puntaje(unaFiesta, unaPersona){
		return caracteristicas.sum({unaCaracteristica=> unaCaracteristica.puntos(unaPersona, unaFiesta)})
	}
}

class Gracioso{
	var property nivelDeGracia
	
	method puntos(persona, unaFiesta){
		if (persona.edad() > 50){
			return nivelDeGracia *3
		}
		return nivelDeGracia
	}
}

class Tobara{
	var property fechaDeCompra
	
	method puntos(persona, unaFiesta){
		if(self.cantDiasDeLaCompra(unaFiesta.fecha()) > 2){
			return 5
		}
		return 3
	}
	method cantDiasDeLaCompra(fechaDeLaFiesta){
		return fechaDeLaFiesta - fechaDeCompra
	}
}

class Careta{
	var property personajeCareta
	
	method puntos(persona, unaFiesta){
		return personajeCareta.valor()
	}
}

class Personaje{
	var property nombre
	var property valor
}

object sexy{
	method puntos(persona, unaFiesta){
		if(persona.esSexy()){
			return 15
		}
		return 2
	}
}

object alegre{
	method esSexy(_) = false
}

object taciturno{
	method esSexy(persona) = persona.edad() < 30
}

class Cambiante{
	var property personalidad
	method esSexy(persona) = personalidad.esSexy(persona)
}

class Caprichoso inherits Invitado{
	override method cumpleCondiciones(_) = self.cantidadDeLetras().even()
	method cantidadDeLetras() = disfraz.nombre().size()
}

class Pretencioso inherits Invitado{
	override method cumpleCondiciones(_) = self.cantidadDeDiasDelDisfraz() < 30
	method cantidadDeDiasDelDisfraz(){
		return new Date() - disfraz.fechaDeFabricacion()
	}
}

class Numerologo inherits Invitado{
	var property cifra
	override method cumpleCondiciones(unaFiesta) = disfraz.puntos(unaFiesta,self) == cifra
}