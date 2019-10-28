module HelperSequences.A003136 (a003136) where
import Data.Set (singleton, union, fromList, deleteFindMin)
-- Reinhard Zumkeller, Oct 30 2011
a003136 :: Int -> Integer
a003136 n = a003136_list !! (n - 1)

a003136_list :: [Integer]
a003136_list = f 0 $ singleton 0 where
  f x s
    | m < x ^ 2 = m : f x s'
    | otherwise = m : f x' (union s' $ fromList $ map (\y -> x'^2+(x'+y)*y) [0..x']) where
      x' = x + 1
      (m, s') = deleteFindMin s
