module HelperSequences.A002262 (a002262) where
import HelperSequences.A000217 (a000217)
import HelperSequences.A003056 (a003056)

a002262 :: Int -> Int
-- a000217(a003056(n)) < n, so fromIntegral is safe.
a002262 n = n - fromIntegral (a000217 $ toInteger $ a003056 n)
