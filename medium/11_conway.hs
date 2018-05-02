import System.IO
import Control.Monad
import Data.List

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let r = read input_line :: Int
    input_line <- getLine
    let l = read input_line :: Int

    putStrLn . unwords . map show $ conway [r] l

conway l 1 = l
conway l n = conway (f $ group l) (n - 1)
    where
        f [] = []
        f (x:xs) = length x : head x : f xs
