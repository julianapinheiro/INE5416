-- Aluna: Juliana Silva Pinheiro
-- Matrícula: 16100735

module SolidosGeometricos(Forma(Esfera, Cilindro, Cone, TroncoCone, 
    EsfOblato, EsfProlato), area, volume, excentricidade) where

data Forma = Esfera Float                      --Raio
                | Cilindro Float Float         --Raio Altura
                | Cone Float Float             --Raio Altura
                | TroncoCone Float Float Float --RaioBase RaioSecçao Altura
                | EsfOblato Float Float        --eixoMaior eixoMenor
                | EsfProlato Float Float       --eixoMaior eixoMenor
        deriving Show

excentricidade :: Float -> Float -> Float
excentricidade a b
    | b < a = sqrt((a^2 - b^2)/(a^2))   -- elipse de oblato
    | b > a = sqrt((b^2 - a^2)/(b^2))   -- elipse de prolato
    | b == a = 0                        -- circulo de esfera

area :: Forma -> Float
area(Esfera r) = 4*pi*r**2
area(Cilindro r h) = 2*pi*r*h + 2*pi*r**2
area(Cone r h) = pi*r*(sqrt(r**2+h**2) + r)
area(TroncoCone r1 r2 h) = pi*r1**2 + pi*r2**2 + pi*(r1+r2)*sqrt(h**2+(r1-r2)**2)
area(EsfOblato a b) = 2*pi*a**2 + (b**2/excentricidade a b) * 
                      log((1 + excentricidade a b)/(1 - excentricidade a b))
area(EsfProlato a b) = 2*pi*b**2 + 2**pi*(a*b/excentricidade a b) * 
                       asin(excentricidade a b)

volume :: Forma -> Float
volume(Esfera r) = (4/3)*pi*r**3
volume(Cilindro r h) = pi*r**2*h
volume(Cone r h) = (1/3)*pi*r**2*h
volume(TroncoCone r1 r2 h) = (1/3)*pi*h*(r1**2 + r2**2 + r1*r2)
volume(EsfOblato a b) = (4/3)*pi*a**2*b
volume(EsfProlato a b) = (4/3)*pi*a*b**2