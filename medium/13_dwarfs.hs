import Control.Applicative
import Control.Monad
import Data.List
import Debug.Trace

main :: IO ()
main = do
    n <- readLn :: IO Int

    links <- replicateM n $ do
            l <- (map read . words) <$> getLine
            return $ (l !! 0, l !! 1)

    print $ longest (maximum $ map fst links ++ map snd links) links

longest n links = maximum acc
    where
        acc = 0:[ d i | i <- [1..n+1] ]
        d i = case map ((acc !!) . snd) . filter ((== i) . fst) $ links of
                [] -> 1
                a -> 1 + maximum a
