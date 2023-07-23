import Data.List
import Data.Text.Lazy.Read 

import Distribution.Simple 

data Usuario = Usuario{nombreUser :: String, edad :: Int, categoria :: String, pais :: String, pelisVistas :: [Pelicula], estadoSalud :: Int}

psicosis = Pelicula "Psicosos" "Terror" 109 "Estados Unidos"
perfumeDeMujer = Pelicula "Perfume de Mujer" "Drama" 150 "Estados Unidos"
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas" "Drama" 95 "Iran"
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran"
juan = Usuario "juan" 23 "estandar" "Argentina" [perfumeDeMujer] 60

ver :: Pelicula -> Usuario -> Usuario
ver pelicula usuario = usuario {pelisVistas = (pelisVistas usuario) ++ [pelicula]}

--Tremenda idea de aquí para abajo
cumpleCondicionPremiar :: Usuario -> Bool
cumpleCondicionPremiar usuario = (>20).length.filter (("Estados Unidos"/=).origen).pelisVistas $ usuario --Pensaba que ese filter iba a mandar error al estar así. Sorprendentemente está bien

nuevaCategoria :: String -> String
nuevaCategoria "basica" = "estandar"
nuevaCategoria _ = "premium"


subirCategoria :: Usuario -> Usuario
subirCategoria usuario = usuario {categoria = nuevaCategoria.categoria $ usuario}

premiarSiCorresponde :: Usuario -> Usuario
premiarSiCorresponde usuario    |cumpleCondicionPremiar usuario = subirCategoria $ usuario
                                |otherwise = usuario

premiar :: [Usuario] -> [Usuario]
premiar usuarios = map premiarSiCorresponde usuarios  
type Criterio = Pelicula -> Bool

teQuedasteCorto :: Criterio
teQuedasteCorto pelicula = (>35).duracion $ pelicula

type Genero = String
cuestionDeGenero :: [Genero] -> Criterio
cuestionDeGenero generos pelicula = elem (generoPeli pelicula) generos

deDondeSaliste :: String -> Criterio
deDondeSaliste lugar pelicula = lugar == origen pelicula

vaPorEseLado :: (Eq t) => Pelicula -> (Pelicula -> t) -> Criterio
vaPorEseLado pelicula f otraPelicula = f pelicula == f otraPelicula

{-
cumpleCondiciones :: [Criterio] -> Usuario -> Pelicula -> Bool
cumpleCondiciones criterios usuario pelicula = elem pelicula (pelisVistas usuario) && all (($) pelicula) criterios --Este sí que trajo error xd
-}

cumpleCondiciones :: [Criterio] -> Usuario -> Pelicula -> Bool
cumpleCondiciones criterios usuario pelicula = not(elem pelicula (pelisVistas usuario)) && and (map ($ pelicula) criterios)

pelisRecomendadas :: Usuario -> [Criterio] -> [Pelicula] -> [Pelicula]
pelisRecomendadas usuario criterios peliculas = take 3. filter (cumpleCondiciones criterios usuario) $ peliculas

-- STOP Lo de arriba está bien bueno