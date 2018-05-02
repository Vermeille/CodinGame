import System.IO
import Control.Monad
import Data.List
import Data.Maybe

mkAlpha w r = map mkNbr [0..19]
    where
        mkNbr n = flip map r $ take w . drop (n * w)

-- toNbr :: [[String]] -> Integer
toNbr alpha = sum . zipWith (\p v -> v * 20^p) [0..] . reverse . map (fromJust . (`elemIndex` alpha))

toMayan :: [[String]] -> Int -> [[String]]
toMayan alpha 0 = [alpha !! 0]
toMayan alpha n = reverse $ toM' n
    where
        toM'  0 = []
        toM' n = (alpha !! (n `mod` 20)) : toM' (n `div` 20)

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let input = words input_line
    let l = read (input!!0) :: Int
    let h = read (input!!1) :: Int

    alpha <- mkAlpha l `fmap` replicateM h getLine

    input_line <- getLine
    let s1 = read input_line :: Int

    n1 <- toNbr alpha `fmap` (replicateM (s1 `div` h) $ do
        replicateM h getLine)

    input_line <- getLine
    let s2 = read input_line :: Int

    n2 <- toNbr alpha `fmap` (replicateM (s2 `div` h) $ do
        replicateM h getLine)
    operation <- getLine

    -- hPutStrLn stderr "Debug messages..."

    let res = toMayan alpha $ op operation n1 n2

    mapM_ (mapM_ putStrLn) res

op "+" = (+)
op "-" = (-)
op "*" = (*)
op "/" = div
