import Text.Show.Functions

data Botin = Botin  {nombreBotin :: String, valor :: Integer} deriving Show
data Pirata = Pirata {apodo:: String, tesoro :: [Botin], ideal :: MetodoSaqueo} deriving Show
jackSparrow = Pirata "Jack Sparrow" [Botin "Brújula" 10000, Botin "Frasco de arena" 0] (totalmentePirata [esTesoroValioso, esTesoroParticular "sombreso"])
davidJones = Pirata "David Jones" [Botin "Cajita musical" 1] (conConrazon)
anneBonny = Pirata "Anne Bonny" [Botin "Doblones" 100, Botin "Frasco de arena" 1] (esTesoroParticular "Oro")
kevin = Pirata "Kevin" [Botin "Doblones" 100] (esTesoroValioso)
oro = Botin "Oro" 100

--1
cantidadTesoros pirata = length.tesoro $ pirata
--2
esAfortunado pirata = (>=10000).sum.map valor $ tesoro pirata

--3
tieneTesoro nombre pirata = filter ((==nombre).nombreBotin) $ tesoro pirata

compararValorBotin unBotin otroBotin = (/= (valor unBotin)) $ valor otroBotin

ambosPiratasTienenElTesoso nombre unPirata otroPirata = ((not.null) (tieneTesoro nombre unPirata)) && ((not.null) (tieneTesoro nombre otroPirata)) 

botinConDistintoValor nombre unPirata otroPirata= compararValorBotin (head (tieneTesoro nombre unPirata)) (head(tieneTesoro nombre otroPirata)) 

mismoTesoroDistintoValor nombre unPirata otroPirata = ambosPiratasTienenElTesoso nombre unPirata otroPirata && botinConDistintoValor nombre unPirata otroPirata

--4
tesoroMasValioso pirata = maximum.map valor $ tesoro pirata 

--5
modifTesoro f pirata = pirata {tesoro = f $ tesoro pirata}

nuevoTesoro tesoro pirata = modifTesoro (++[tesoro]) pirata
--6
esTesoroValioso = (>=100).valor 

perderTesorosValiosos pirata = modifTesoro (filter (not.esTesoroValioso)) pirata

--7
esTesoroParticular nombre = (== nombre).nombreBotin
perderParticularmenteUnTesoro nombre pirata = modifTesoro (filter (not.esTesoroParticular nombre)) pirata
 
-- Saqueos
conConrazon :: MetodoSaqueo
conConrazon tesoro = False
totalmentePirata :: [MetodoSaqueo] -> Botin -> Bool
totalmentePirata [] _ = False
totalmentePirata (x:xs) tesoro  | x tesoro = True
                                | otherwise = totalmentePirata xs tesoro
type MetodoSaqueo = (Botin -> Bool)

saquear pirata metodoSaqueo tesoro  | metodoSaqueo tesoro = nuevoTesoro tesoro pirata
                                    | otherwise = pirata
