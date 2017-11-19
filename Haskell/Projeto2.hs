-- Projeto 2 - INE5416/2017.2
-- Aluna: Juliana Silva Pinheiro
-- Matrícula: 16100735

module SomaSeries (somaImpar,  totalImpar, somaPar, totalPar,
                    somaQuad, totalQuad, somaQuadImpar, totalQuadImpar,
                    quaseDois, quaseEuler) where

-- Parte 1 - Séries finitas
somaImpar n = map ( \x -> (x*((2*x-1)+1)/2)) [1..n]
totalImpar n = last (somaImpar(n))

somaPar n = map ( \x -> (x*(2*x + 2)/2)) [1..n]
totalPar n = last (somaPar(n))

somaQuad n = map ( \x -> (x*(x+1)*(2*x+1)/6)) [1..n]
totalQuad n = last (somaQuad(n))

somaQuadImpar n = map ( \x -> (x*(4*x^2-1)/3)) [1..n]
totalQuadImpar n = last (somaQuadImpar(n))

-- Parte 2 - Séries infinitas
quaseDois n = sum (map (\x -> (2/(x+x^2))) [1..n])
quaseEuler n = 1 + sum (map (\x -> (1 / product[1..x])) [1..n])

