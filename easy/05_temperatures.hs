import System.IO
import Control.Monad
import Control.Applicative
import Data.List
import Data.Ord

strangeCmp :: Int -> Int -> Ordering
strangeCmp a b =
        if abs a == abs b then
            if a > 0 then LT else GT
        else
            if abs a < abs b then LT else GT

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let n = read input_line :: Int -- the number of temperatures to analyse
    if n == 0 then
        putStrLn "0"
    else do
        temps <- (map read . words) <$> getLine
        -- the N temperatures expressed as integers ranging from -273 to 5526

        print . minimumBy strangeCmp $ temps
