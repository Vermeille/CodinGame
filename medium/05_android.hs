import System.IO
import Control.Monad
import Data.Map

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let input = words input_line
    let nbfloors = read (input!!0) :: Int -- number of floors
    let width = read (input!!1) :: Int -- width of the area
    let nbrounds = read (input!!2) :: Int -- maximum number of rounds
    let exitfloor = read (input!!3) :: Int -- floor on which the exit is found
    let exitpos = read (input!!4) :: Int -- position of the exit on its floor
    let nbtotalclones = read (input!!5) :: Int -- number of generated clones
    let nbadditionalelevators = read (input!!6) :: Int -- ignore (always zero)
    let nbelevators = read (input!!7) :: Int -- number of elevators

    floors <- ((exitfloor, exitpos):) `fmap` (replicateM nbelevators $ do
            input_line <- getLine
            let input = words input_line
            let elevatorfloor = read (input!!0) :: Int -- floor on which this elevator is found
            let elevatorpos = read (input!!1) :: Int -- position of the elevator on its floor
            return (elevatorfloor, elevatorpos))

    let floorsmap = fromList floors

    forever $ do
        input_line <- getLine
        let input = words input_line
        let clonefloor = read (input!!0) :: Int -- floor of the leading clone
        let clonepos = read (input!!1) :: Int -- position of the leading clone on its floor
        let direction = input!!2 -- direction of the leading clone: LEFT or RIGHT

        hPutStrLn stderr . show $ (clonefloor, clonepos, direction)

        putStrLn $ shouldBlock direction clonepos (floorsmap ! clonefloor)

shouldBlock "LEFT" p e = if p < e then "BLOCK" else "WAIT"
shouldBlock "RIGHT" p e = if p > e then "BLOCK" else "WAIT"
shouldBlock _ _ _ = "WAIT"
