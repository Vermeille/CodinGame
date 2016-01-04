import System.IO
import Control.Monad
import Data.List
import Data.Ord

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    loop

maxIndex = fst . maximumBy (comparing snd) . zip [0..]

loop :: IO ()
loop = do
    input_line <- getLine
    let input = words input_line
    let sx = read (input!!0) :: Int
    let sy = read (input!!1) :: Int

    mountains <- replicateM 8 $ do
        input_line <- getLine
        let mh = read input_line :: Int -- represents the height of one mountain, from 9 to 0. Mountain heights are provided from left to right.
        return mh

    -- either:  FIRE (ship is firing its phase cannons) or HOLD (ship is not firing).
    putStrLn $ if maxIndex mountains == sx then "FIRE" else "HOLD"

    loop
