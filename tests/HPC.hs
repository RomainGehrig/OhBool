
module Main (main) where

import Data.List (genericLength)
import Data.Maybe (catMaybes)
import System.Exit (exitFailure, exitSuccess)
import System.Process (readProcess)
import Text.Regex (matchRegex, mkRegex)

average :: (Fractional a, Real b) => [b] -> a
average xs = realToFrac (sum xs) / genericLength xs

expected :: Fractional a => a
expected = 90

main :: IO ()
main = do
    output <- readProcess "hpc" ["report", "dist/hpc/tix/hspec/hspec.tix"] ""
    if average (match output) >= expected
        then exitSuccess
        else putStr output >> exitFailure

match :: String -> [Int]
match = fmap read . concat . catMaybes . fmap (matchRegex pattern) . lines
  where
    pattern = mkRegex "^ *([0-9]*)% "
