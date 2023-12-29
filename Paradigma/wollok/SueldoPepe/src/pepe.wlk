/** First Wollok example */
object pepe {
	var property categoria = cadete
	var property cantFaltas = 3
	var property bonoPresentismo = bonoDependeDeFaltas
	var property bonoResultado = bonoPorcentaje
	
	method sueldo(){
		return categoria.neto() + bonoPresentismo.monto(cantFaltas) + bonoResultado.monto( categoria.neto() )
	}
	
}

object cadete{
	const neto = 15000
	method neto()= neto
}

object gerente{
	const neto = 20000
	method neto()= neto
}

object bonoDependeDeFaltas{
	method monto(faltas){
		if (faltas == 0){
			return 1000
		}
		if (faltas == 1){
			return 500
		}
		
		return 0
	}
}

object bonoNulo{
	method monto(_) = 0
}

object bonoPorcentaje{
	method monto(neto) = neto * 0.1
}

object bonoFijo{
	method monto(_) = 800
}