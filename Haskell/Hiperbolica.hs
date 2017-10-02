module Hiperbolicas (FunHiperbolica (Sinh, Cosh, Tanh, Coth), e, valor) where

data FunHiperbolica = Sinh Float 
                    | Cosh Float
                    | Tanh Float
                    | Coth Float
                deriving Show

e = exp 1

valor :: FunHiperbolica -> Float
valor (Sinh x) = (e**x - e**(-x))/2
valor (Cosh x) = (e**x + e**(-x))/2
valor (Tanh x) = (valor (Sinh x))/(valor (Cosh x))
valor (Coth x) = (valor (Cosh x))/(valor (Sinh x))

