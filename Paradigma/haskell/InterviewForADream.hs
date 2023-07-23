{-import Data.List (nub)
union' :: (Eq a) => [a] -> [a] -> [a]
union' xs ys = nub (xs ++ ys)
-}

-- Estructuras
data Postulante = UnPostulante {nombre :: String, edad :: Double, remuneracion :: Double, conocimientos :: [String]} deriving Show 
data Puesto = UnPuesto {puesto:: String, conocimientoRequeridos :: [String]} deriving Show
data Estudiante = UnEstudiante {legajo :: Double, conocimientosEstudiante :: [String]} deriving Show
data Persona = Postulante | Estudiante
-- Tipos nuevos
type Requisito = Postulante -> Bool
type Nombre = String
apellidoDueno:: Nombre

--Ejemplos
pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C"]
tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]

jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]
chePibe = UnPuesto "cadete" ["ir al banco"]

apellidoDueno = "Gonzalez"

fred = UnEstudiante 1220006 ["Haskell", "Php"]
-- Parte 1 
tieneConocimientos :: Puesto -> Requisito
tieneConocimientos puesto postulante = all (\requerido -> elem requerido (conocimientos postulante)).conocimientoRequeridos $ puesto 

edadAceptable :: Double -> Double -> Requisito
edadAceptable edadMin edadMax postulante = (>=edadMin) (edad postulante) && (<=edadMax) (edad postulante)

sinArreglo :: Requisito
sinArreglo postulante = (/=apellidoDueno) (last(words (nombre postulante))) 

-- Parte 2
propuestaA :: [Requisito]
propuestaA = [tieneConocimientos jefe , edadAceptable 30 40 , sinArreglo]

{-
preseleccion :: [Postulante] -> [Requisito] -> [Postulante]
preseleccion postulante requisito = filter (last requisito) postulante
-}

-- Parte 3
incrementarEdad :: Postulante -> Postulante
incrementarEdad postulante = postulante {edad = (+1).edad $ postulante}

aumentarSueldo :: Double -> Postulante -> Postulante 
aumentarSueldo porcentaje postulante = postulante {remuneracion = (*porcentaje).remuneracion $ postulante}

--b
actualizarPostulantes :: [Postulante] -> [Postulante]
actualizarPostulantes listaPostulantes = map ((\auxilio -> aumentarSueldo 1.27 auxilio).incrementarEdad) listaPostulantes
{-repeat pepe-}

--Parte 4
capacitar :: Postulante -> String -> Postulante 
capacitar postulante conocimiento = postulante {conocimientos = (++[conocimiento]).conocimientos $ postulante}

capacitar' :: Postulante -> Postulante 
capacitar' postulante = postulante {conocimientos = conocimientos postulante}

capacitarEstudiante :: Estudiante -> String -> Estudiante
capacitarEstudiante estudiante conocimiento = estudiante {conocimientosEstudiante = (++[conocimiento]).reverse.(\auxilio-> drop 1 auxilio).reverse.conocimientosEstudiante $ estudiante}

{-
capacitacion :: Puesto -> Persona -> Persona
capacitacion puesto postulante = postulante {conocimientos = union' (conocimientoRequeridos puesto) (conocimientos postulante)}
capacitacion puesto estudiante = estudiante {conocimientosEstudiante = (union' (conocimientoRequeridos puesto) (conocimientosEstudiante estudiante))}
-}

