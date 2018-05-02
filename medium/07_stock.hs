import System.IO
import Control.Monad
import Control.Applicative
import Debug.Trace

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let n = read input_line :: Int
    vs <- (map read . words) <$> getLine

    print $ kadane vs (vs !! 0) 0

kadane :: [Int] -> Int -> Int -> Int
kadane [] _ m = m
kadane (v:vs) cur m =
        if diff > 0 then
            kadane (v:vs) v m
        else
            kadane vs cur (min diff m)
    where
        diff = v - cur
