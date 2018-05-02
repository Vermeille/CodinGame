import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let input = words input_line
    let w = read (input!!0) :: Int -- width of the building.
    let h = read (input!!1) :: Int -- height of the building.
    input_line <- getLine
    let n = read input_line :: Int -- maximum number of turns before game over.
    input_line <- getLine
    let input = words input_line
    let x0 = read (input!!0) :: Int
    let y0 = read (input!!1) :: Int
    loop ((0, w), (0, h)) (x0, y0)

loop ((w, w'), (h, h')) (x, y) = do
    input_line <- getLine
    let bomb_dir = input_line :: String -- the direction of the bombs from batman's current location (U, UR, R, DR, D, DL, L or UL)

    let n = case bomb_dir of
            "D" -> (((w, w'), (y + 1, h')) , (x, (h' + y + 1) `div` 2))
            "DR" -> (((x + 1, w'), (y + 1, h')) , ((x + w' + 1) `div` 2, (h' + y) `div` 2))
            "R" -> (((x + 1, w'), (h, h')) , ((x + w' + 1) `div` 2, y))
            "UR" -> (((x + 1, w'), (h, y - 1)) , ((x + w' + 1) `div` 2, (h + y - 1) `div` 2))
            "U" -> (((w, w'), (h, y - 1)) , (x, (h + y - 1) `div` 2))
            "UL" -> (((w, x - 1), (h, y - 1)) , ((w + x - 1) `div` 2, (h + y - 1) `div` 2))
            "L" -> (((w, x - 1), (h, h')) , ((x + w - 1) `div` 2, y))
            "DL" -> (((w, x - 1), (y + 1, h')) , ((x + w - 1) `div` 2, (h' + y + 1) `div` 2))
    putStrLn $ (show . fst . snd $ n) ++ " " ++ (show . snd . snd $ n)
    loop (fst n) (snd n)
