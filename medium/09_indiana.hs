import System.IO
import Control.Monad
import Data.Array
import Prelude hiding (Either(..))

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let input = words input_line
    let w = read (input!!0) :: Int -- number of columns.
    let h = read (input!!1) :: Int -- number of rows.

    mapList <- replicateM h $ do
        line <- getLine
        -- represents a line in the grid and contains W integers. Each integer represents one room of a given type.
        hPutStrLn stderr line
        return . map read . words $ line :: IO [Int]
    input_line <- getLine
    let ex = read input_line :: Int -- the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

    let world = listArray ((0, 0), (h - 1, w - 1)) $ concat mapList
    loop world

data Dir = Top | Left | Right | Down

next 0 _    = Down
next 1 _    =  Down
next 2 Left = Right
next 2 Right= Left
next 3 _    = Down
next 4 Top  = Left
next 4 Right= Down
next 5 Top  = Right
next 5 Left = Down
next 6 d    = next 2 d
next 7 _    = Down
next 8 _    = Down
next 9 _    = Down
next 10 Top = Left
next 11 Top = Right
next 12 Right= Down
next 13 Left= Down

toDir "TOP" = Top
toDir "LEFT" = Left
toDir "RIGHT" = Right

bite (x, y) Down = (x, y + 1)
bite (x, y) Left = (x - 1, y)
bite (x, y) Right = (x + 1, y)

loop world = do
    input_line <- getLine
    let input = words input_line
    let xi = read (input!!0) :: Int
    let yi = read (input!!1) :: Int
    let pos = input!!2

    let t = (world ! (yi, xi))
    hPutStrLn stderr $ show world
    hPutStrLn stderr $ show t
    let n = (xi, yi) `bite` next t (toDir pos)

    putStrLn $ (show $ fst n) ++ " " ++ (show $ snd n)

    loop world
