import System.IO
import Control.Monad
import Data.Map (alter, fromList, empty, (!))
import Data.List
import Data.Ord

pts = fromList $ zip ['a'..'z'] [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]

wordPts l w =
    if all (>= 0) $ map (ldec !) w then
        sum $ map (pts !) w
    else
        0
    where
        ldec = foldl dec l w

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.

    input_line <- getLine
    let n = read input_line :: Int

    wds <- reverse `fmap` (replicateM n $ do
        getLine)

    letters <- getLine
    let lmap = foldl inc (fromList $ zip ['a'..'z'] (repeat 0)) letters
    hPutStrLn stderr letters
    hPutStrLn stderr (show lmap)

    putStrLn . fst . maximumBy (comparing snd) . zip wds . map (wordPts lmap) $ wds

inc m c = alter inc' c m
    where
        inc' Nothing = Just 0
        inc' (Just c) = Just $ c + 1

dec m c = alter dec' c m
    where
        dec' Nothing = Just 0
        dec' (Just c) = Just $ c - 1
