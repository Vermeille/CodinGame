import System.IO
import Control.Monad
import Data.Maybe
import Data.List
import System.FilePath.Posix
import Data.Char

ext f = let f' = takeExtension f in if null f' then f' else drop 1 f'

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE

    input_line <- getLine
    let n = read input_line :: Int -- Number of elements which make up the association table.
    input_line <- getLine
    let q = read input_line :: Int -- Number Q of file names to be analyzed.

    types <- replicateM n $ do
        input_line <- getLine
        let input = words input_line
        let ext = input!!0 -- file extension
        let mt = input!!1 -- MIME type.
        return (map toLower ext, mt)

    files <- replicateM q $ do
        fname <- getLine
        -- One file name per line.
        return fname

    mapM_ (putStrLn . fromMaybe "UNKNOWN" . (`lookup` types) . map toLower . ext) files
    -- For each of the Q filenames, display on a line the corresponding MIME type. If there is no corresponding type, then display UNKNOWN.
