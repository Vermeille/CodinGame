import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let r = read input_line :: Int -- the length of the road before the gap.
    input_line <- getLine
    let g = read input_line :: Int -- the length of the gap.
    input_line <- getLine
    let l = read input_line :: Int -- the length of the landing platform.
    loop (r, g, l) 0

loop (r, g, l) p = do
    input_line <- getLine
    let s = read input_line :: Int -- the motorbike's speed.
    input_line <- getLine
    let x = read input_line :: Int -- the position on the road of the motorbike.

    hPutStrLn stderr . show $ ((r, g, l), (s, x))

    -- A single line containing one of 4 keywords: SPEED, SLOW, JUMP, WAIT.
    let action =  if p >= r + g then (-1, "SLOW")
                    else if s < g + 1 then (1, "SPEED")
                    else if s > g + 1 then (-1, "SLOW")
                    else if p == r - 1 then (0, "JUMP")
                    else (0, "WAIT")

    putStrLn $ snd action

    loop (r, g, l) (p + s + fst action)
