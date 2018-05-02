import System.IO
import Control.Monad
import Control.Applicative
import Data.List

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let n = read input_line :: Int
    input_line <- getLine
    let c = read input_line :: Int

    maxs <- sort `fmap` (replicateM n $ do
        input_line <- getLine
        return (read input_line :: Int))

    hPutStrLn stderr $ show (maxs, c)

    case distrib c maxs of
        Nothing -> putStrLn "IMPOSSIBLE"
        Just costs -> mapM_ (putStrLn . show) costs

distrib c [l] = if c > l then Nothing else Just [c]
distrib c (m:ms) =
    let ideal = c `div` (1 + length ms)
    in  if ideal > m then
            (m:) <$> distrib (c - m) ms
        else
            (ideal:) <$> distrib (c - ideal) ms
