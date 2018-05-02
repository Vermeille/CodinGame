import System.IO
import Control.Monad
import Data.Char

data Tree a = Empty | Node a [Tree a] deriving (Show)

mkNode v = Node v $ replicate 10 Empty

toDigit c = ord c - ord '0'

mkTree [] = []
mkTree ns = flip map [0..9] $ \d ->
        let ns' = filter (startsWith d) ns
        in case ns' of
            [] -> Empty
            _ -> Node d $ mkTree (filter (not . null) . map tail $ ns')
    where
        startsWith d = (== d) . toDigit . head

depth [] = 0
depth xs = sum . map d $ xs
    where
        d Empty = 0
        d (Node _ ns) = 1 + depth ns

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let n = read input_line :: Int

    nbrs <- mkTree `fmap` replicateM n getLine

    print $ depth nbrs

    -- The number of elements (referencing a number) stored in the structure.
