import Text.Show.Functions
-- Parte A

type Genero = Usuario -> Usuario
data Libro = Libro {titulo :: String, autor:: String, paginas :: Integer, genero :: Genero} deriving Show

data Usuario = Usuario {nick :: String, felicidad:: Integer, librosConseguidos :: [Libro], librosLeidos :: [Libro]} deriving Show

trilogiaImperio = Libro "Trilogía Imperio" "Isaac Asimov" 237 cienciaFiccion
john = Usuario "johnTitor" 20 [trilogiaImperio] [trilogiaImperio,trilogiaImperio]
-- Parte B

modificarFelicidad f usuario = usuario {felicidad = f $ felicidad usuario}
comedia :: String -> Genero
comedia "Dramatica" usuario = usuario
comedia "Absurda" usuario = modificarFelicidad (+5) usuario
comedia "Satirica" usuario = modificarFelicidad (*2) usuario
comedia _ usuario = modificarFelicidad (+10) usuario

cienciaFiccion usuario = usuario {nick = reverse.nick $ usuario}

terror usuario = usuario {librosConseguidos = []}

-- Parte C


agregarLibro libro usuario = usuario {librosLeidos = (++[libro]).librosLeidos $ usuario}


leerLibro usuario libro = (genero libro)  (agregarLibro libro usuario)

-- De acá para abajo estaban jodidos.
maratonLibros :: Usuario -> Usuario
maratonLibros usuario = foldl leerFaltante usuario (librosConseguidos usuario)

leerFaltante :: Usuario -> Libro -> Usuario
leerFaltante usuario libro  |not.fueLeido libro $ usuario = leerLibro usuario libro
                            |otherwise = usuario

fueLeido :: Libro -> Usuario -> Bool 
fueLeido libro usuario = any (mismoLibro libro). librosLeidos $ usuario

mismoLibro :: Libro -> Libro -> Bool
mismoLibro unLibro otroLibro = (titulo unLibro == titulo otroLibro) && (autor unLibro == autor otroLibro)


soloUnAutor usuario unAutor= all ((==unAutor).autor) (librosLeidos usuario)

cuento libro = (<100).paginas $ libro 
novelaCorta libro = ((>=100).paginas) libro && ((<=200).paginas) libro
novela libro = (>200).paginas $ libro 

titulosLibrosAdquiridos tipo usuario = map titulo . filter tipo . librosConseguidos $ usuario