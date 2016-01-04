import System.IO
import Control.Monad
import Control.Applicative

data Vec = Vec Int Int deriving (Show)

addV (Vec x y) (Vec x' y') = Vec (x + x') (y + y')
subV (Vec x y) (Vec x' y') = Vec (x - x') (y - y')

main :: IO ()
    main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let input = words input_line
    let lx = read (input!!0) :: Int -- the X position of the light of power
    let ly = read (input!!1) :: Int -- the Y position of the light of power
    let tx = read (input!!2) :: Int -- Thor's starting X position
    let ty = read (input!!3) :: Int -- Thor's starting Y position
    let light = Vec lx ly
    let thor = Vec tx ty
    loop light thor

getDir (Vec x y) = Vec (if x > 0 then 1 else if x < 0 then -1 else 0) (if y > 0 then 1 else if y < 0 then -1 else 0)

toCard (Vec 1 0) = "E"
toCard (Vec 1 1) = "SE"
toCard (Vec 0 1) = "S"
toCard (Vec (-1) 1) = "SW"
toCard (Vec (-1) 0) = "W"
toCard (Vec (-1) (-1)) = "NW"
toCard (Vec 0 (-1)) = "N"
toCard (Vec 1 (-1)) = "NE"

loop :: Vec -> Vec -> IO ()
    loop light thor = do
    input_line <- getLine
    let e = read input_line :: Int -- The level of Thor's remaining energy, representing the number of moves he can still make.

    let dir = getDir $ light `subV` thor

    -- A single line providing the move to be made: N NE E SE S SW W or NW
    hPutStrLn stderr . show $ (light, thor, dir)
    putStrLn $ toCard dir

    loop light (thor `addV` dir)
