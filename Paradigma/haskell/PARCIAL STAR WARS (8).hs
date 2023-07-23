
--ENUNCIADO: https://docs.google.com/document/d/1rbOy1rIFmBxMRhTOWvI-u097l9KatHRbqt5KBXvVSfI/edit?usp=sharing

module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

type Poder = Nave->Nave
data Nave= UnaNave{
    nombre :: String,
    durabilidad :: Number,
    escudo :: Number,
    ataque :: Number,
    poder :: Poder
}deriving (Eq,Show)

type FlotaEspacial = [Nave]


--Punto 1
tie :: Nave
tie=UnaNave {nombre="TIE Fighter",durabilidad=200,escudo=100,ataque=50,poder=movimientoTurbo}

xWing :: Nave
xWing=UnaNave {nombre="X Wing",durabilidad=300,escudo=150,ataque=100,poder=reparacionDeEmergencia}

naveDarVader :: Nave
naveDarVader = UnaNave {nombre="Nave de Darth Vader",durabilidad=500,escudo=300,ataque=200,poder=superTurbo}

halconMilenario :: Nave
halconMilenario = UnaNave {nombre="Millenium Falcon",durabilidad=1000,escudo=500,ataque=50,poder=reparacionTurbo}

razor :: Nave
razor = UnaNave {nombre="Razor Crest",durabilidad=400,escudo=200,ataque=150,poder=superAtaque}

movimientoTurbo :: Poder
movimientoTurbo nave = nave{ataque=ataque nave+25}

reparacionDeEmergencia :: Poder
reparacionDeEmergencia nave= nave{durabilidad=durabilidad nave+50,ataque=ataque nave - 30}

superTurbo :: Poder
superTurbo nave = ((movimientoTurbo.movimientoTurbo).movimientoTurbo) nave {durabilidad=durabilidad nave - 45}

superAtaque :: Poder
superAtaque nave = nave{ataque=ataque nave *2,escudo=escudo nave - 100}

reparacionTurbo :: Poder
reparacionTurbo nave = reparacionDeEmergencia nave{escudo=escudo nave +100}

--Punto 2

flotaPrueba=[tie,tie,razor]
flotaPrueba2=[tie,tie,naveDarVader,tie,tie]

durabilidadTotal :: FlotaEspacial->Number
durabilidadTotal = sum.map durabilidad

--Punto 3

combate :: Nave->Nave->Nave
combate naveAtaque naveDefensa= activarPoder naveDefensa naveDefensa {durabilidad=durabilidad naveDefensa- danoRecibido (activarPoder naveAtaque naveAtaque) naveDefensa}

danoRecibido :: Nave->Nave->Number
danoRecibido naveAtaque naveDefensa
 | ataque naveAtaque > escudo naveDefensa = calculo (ataque naveAtaque) (escudo naveDefensa)
 | otherwise = 0

calculo :: Number->Number->Number
calculo dato1 dato2
 |dato1-dato2 <=0 = 0
 |otherwise = dato1-dato2

--ERROR activar poder
activarPoder :: Nave -> Poder
activarPoder = poder

--Punto 4

fueraDeCombate :: Nave->Bool
fueraDeCombate= (0==).durabilidad

--Punto 5

type Estrategia = Nave->Bool
type EstrategiaConValor = Number->Nave->Bool

misionSopresa :: Number->EstrategiaConValor->Nave->FlotaEspacial->FlotaEspacial
misionSopresa _ _ _ []=[]
misionSopresa  valor estrategia nave (m:ms)
    | estrategia valor m = combate nave m : misionSopresa valor estrategia nave ms
    | otherwise = misionSopresa valor estrategia nave ms

navesDeviles :: EstrategiaConValor
navesDeviles valor= (valor>=) . escudo

peligrosidad :: EstrategiaConValor
peligrosidad valor=(valor<=) . ataque

navesFueraDeCombate :: EstrategiaConValor
navesFueraDeCombate valor = fueraDeCombate

nuevaEstrategia :: Estrategia
nuevaEstrategia = (/="Nave de Darth Vader").nombre
--No se ataca a Darth Vader (es de los mejores pilotos de la galaxia y es una sentencia de muerte)

--Punto 6

compararEstrategias :: Number->EstrategiaConValor->EstrategiaConValor->Nave->FlotaEspacial->FlotaEspacial
compararEstrategias valor estrategia1 estrategia2 nave flota
 | durabilidadTotal (misionSopresa valor estrategia1 nave flota) < durabilidadTotal (misionSopresa valor estrategia2 nave flota) = misionSopresa valor estrategia1 nave flota
 | otherwise = misionSopresa valor estrategia2 nave flota

--Punto 7

{-No podriamos calcular la durabilidad total de una flota infinita, dado que la misma nunca dejaria de crecer y por lo
tanto no tendriamos un valor concreto

Lo mismo sucederia con las misiones sorpresa, al no tener un limite de naves dentro de la flota no sabriamos hasta donde aplicar las dstintas estrategias
a las infinitas naves -}