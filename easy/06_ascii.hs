import System.IO
import Control.Monad
import Data.Char

mkLetter :: [String] -> Int -> Int  -> [String]
mkLetter alpha width letter = [ take width . drop (letter * width) $ line | line <- alpha ]

letterIdx c = if 'A' <= c && c <= 'Z' then ord c - ord 'A' else 26

printMsg :: Int -> [[String]] -> IO ()
printMsg h msg = mapM_ printLine [0..(h - 1)]
    where
        printLine i = do
                mapM_ (putStr . (!! i)) msg
                putStr "\n"

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let l = read input_line :: Int
    input_line <- getLine
    let h = read input_line :: Int
    t <- getLine

    lines <- replicateM h $ do
        row <- getLine
        return row

    let alpha = map (mkLetter lines l) [0..26]

    printMsg h $ map ((alpha !!) . letterIdx . toUpper) t
