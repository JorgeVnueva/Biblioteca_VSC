/** First Wollok example */
class Vehiculo {
	siniestros
	poliza
}

class Siniestro {
	danios
}

class Danio{
	involucrado
	monto
}

cambian estados -> Cambia un nombre entonces

class Poliza{
	asegurardora
}

class Aseguradora{
	
}

class ContraTerceros{
	montoNoCubierto(siniestro, vehiculo)
}

ContraTodoRiesgo --|> Poliza
ContraTercero --|> Poliza
Vehiculo --|> Siniestro
Siniesto --|> Danio