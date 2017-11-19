{- 
    Projeto 3 - INE5416/2017.2
    Aluna: Juliana Silva Pinheiro
    Matrícula: 16100735

    Uso: runhaskell Projeto3.hs [nomedoarquivo].bmp
-}

import Data.Char
import System.Environment
import System.IO
import Data.List

{-
    Modulo principal
    @Params: archive  nome do arquivo bmp
-}
main :: IO ()
main = do
    args <- getArgs
    case args of
        [archive] -> do
            hIn <- openBinaryFile archive ReadMode
            toString <- hGetContents hIn
            saveLayers archive (processLayers toString)
            hClose hIn
        _ -> putStrLn "Uso: runhaskell Projeto3.hs [nomedoarquivo].bmp"


{-
    Salva as camadas em floating point em arquivos txt.
    @Params: inputName  nome do arquivo bmp
             output     conteúdo das camadas a serem salvas
-}
saveLayers input output = do
    saveLayer input "_red.txt" (output!!0)
    saveLayer input "_green.txt" (output!!1)
    saveLayer input "_blue.txt" (output!!2)

{-
    Salva uma camada em arquivo.
    @Params: input     nome do arquivo bmp
             nome      string cor.txt
             output    conteúdo das camadas a serem salvas
-}
saveLayer input nome output = do
    let fileName = take (length input - 4) input
    let outputName = (fileName++) nome
    outFiles <- openFile outputName WriteMode
    hPrint outFiles output
    hClose outFiles

{-
    Converte as camadas para pontos flutuantes.
    @Params: toString   conteudo do arquivo
    @Return: lista dos pontos flutuantes   (r,g,b)
-}
processLayers :: String -> [[Float]]
processLayers toString = do
    let content = snd (splitAt 54 (map ord toString))
    let rgb = split 3 content
    -- Arquivos .bmp são Little Endian, por isso RGB => [b, g, r]
    let r = (map (\x -> fromIntegral (x!!2) / 255) rgb)  
    let g = (map (\x -> fromIntegral (x!!1) / 255) rgb)
    let b = (map (\x -> fromIntegral (x!!0) / 255) rgb)
    return [r, g, b]!!0

{- 
    Separa uma lista em partes de tamanho n.
    @Param: n   tamanho das partes
            xs  lista
    @Return: lista das partes
-}
split :: Int -> [Int] -> [[Int]]
split n [] = []
split n xs = (take n xs):(split n (drop n xs))