import System.IO
import Control.Monad
import Data.Ord
import Data.List

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split p l = let (h, t) = break p l in h : (split p $ drop 1 t)

replace x y = map (\a -> if a == x then y else a)

data Defib = Defib
        { name :: String
        , lon :: Double
        , lat :: Double } deriving (Show)

dist :: Double -> Double -> Defib -> (String, Double)
dist lon lat (Defib n lon' lat') = (n, sqrt (x * x + y * y) * 6371)
    where
        x = (lon' - lon) * cos ((lat + lat') / 2)
        y = lat' - lat

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let lon = read . replace ',' '.' $ input_line :: Double
    input_line <- getLine
    let lat = read . replace ',' '.' $ input_line :: Double
    input_line <- getLine
    let n = read input_line :: Int

    d <- replicateM n $ do
        defib <- getLine
        let parsed = split (== ';') defib
        return $ Defib (parsed !! 1) (read . replace ',' '.'$ parsed !! 4) (read . replace ',' '.' $ parsed !! 5)

    putStrLn . fst . minimumBy (comparing snd) . map (dist lon lat) $ d

