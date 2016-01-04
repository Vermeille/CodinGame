import System.IO
import Control.Monad
import Data.Bits
import Data.Char
import Data.List

byteToBits b = map (testBit b) [6, 5..0]

showNorris l = (if l !! 0 then "0 " else "00 ") ++ replicate (length l) '0' ++ ""

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    message <- getLine

    putStrLn . intercalate " " . map showNorris . group . concatMap (byteToBits . ord) $ message
