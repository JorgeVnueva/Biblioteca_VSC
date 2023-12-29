/** First Wollok example */
object negocio {
	var disponible = 100000
	
	method liquidarSueldoPara(unEmpleado){
		disponible -= unEmpleado.sueldo()
	}
	
	method disponible() = disponible
	
}

object galvan{
	var sueldo = 15000
	
	method sueldo() = sueldo
}

object baigorria{
	var cantEmpanadasVendidas = 10
	var montoCobroPorEmpanada = 300
	
	method sueldo() = cantEmpanadasVendidas * montoCobroPorEmpanada
}