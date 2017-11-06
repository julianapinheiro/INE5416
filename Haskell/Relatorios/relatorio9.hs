import Data.List

-- Juliana Silva Pinheiro 16100735
-- Proposta: soma e produto dos termos de uma PA de n termos e razao r
-- usando formula geral e usando uma lista.

razao :: [Int] -> Int
razao l = l!!1 - l!!0

factorial n = product[1..n]

gama n = factorial(n-1)

-- Soma usando lista
somaPA l = sum(l)

-- Soma usando fórmula geral
sumPA l = (length(l) * (l!!0 + last(l))) `div` 2

-- Produto
productAP l
    |   razao(l) == 1 = factorial(last(l)) `div` factorial(l!!0 - 1)
    |   razao(l) /= 1 = razao(l) ^ length(l) *
                    gama(l!!0`div`razao(l) + length(l)) 
                    `div` gama(l!!0`div`razao(l))
