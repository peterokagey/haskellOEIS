module Sandbox.CycleStructure where
import Data.Set (fromList, delete, member)
import Data.List (permutations, (\\))

type PermutationWord = [Int]
type Cycle = [Int]
type CycleStructure = [[Int]]

fromWord p = recurse 1 [] (fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen       = [reverse currentCycle]
    | x `member` unseen = recurse (p !! (x-1)) (x:currentCycle) (delete x unseen)
    | otherwise         = reverse currentCycle : recurse (minimum unseen) [] unseen

fromCycleStructure c = map findValue [1..n] where
  n = maximum $ concat c
  findValue = recurse c where
    recurse (c':cs') i
      | i `elem` c' = case dropWhile (/= i) c' of [_]     -> head c'
                                                  (_:a:_) -> a
      | otherwise = recurse cs' i

countKCycles :: Int -> [[a]] -> Int
countKCycles k cycleStructure = length $ filter ((==k) . length) cycleStructure

rescale :: Int -> CycleStructure -> CycleStructure
rescale k = map rescale' where
  rescale' = map (\i -> if i >=k then i + 1 else i)

insertIntoCycle k (a:as) = a:k:as

phi :: Int -> Int -> CycleStructure -> CycleStructure
-- phi k n cycleStructure = phi' k n $ rescale n cycleStructure

-- phi' :: Int -> Int -> CycleStructure -> CycleStructure
-- phi' k x []                    = [[x]]
-- phi' k x [[a]]                 = if x < a then [[x], [a]] else [[a,x]] -- This only gets hit for permutations in S_{2n + 1}
-- phi' k x p@([a]:[b]:cs)        = if x < a then [x]:p else [a, x, b]  : cs
-- phi' k x p@([a]:[b1,b2]:cs)    = if x < a then [x]:p else [a, x, b2] : cascade b1 cs
-- phi' k x p@([a]:[b1,b2,b3]:cs) = if x < a then [x]:p else [a, x, b2] : [b1] : phi' b3 cs
-- phi' k x p@([a]:(b1:b2:bs):cs) = if x < a then [x]:p else [a, x, b2] : (b1:bs):cs
-- phi' k x p@([a,b]:cs)          = if x < a then [x]:p else [a, x] : phi' b cs
-- phi' k x p@(p'@(a:_):ps')      = if x < a then [x]:p else insertIntoCycle x p' : ps'

-- cascade :: Int -> CycleStructure -> CycleStructure
-- cascade x []                    = [[x]]
-- cascade x ([a]:cycles)          = [a, x]: cycles
-- cascade x ([a1, a2]:cycles)     = [x, a2] : cascade a1 cycles
-- cascade x ([a1, a2, a3]:cycles) = [x, a2] : [a1] : phi' a3 cycles
-- cascade x ((a1:a2:as):cycles)   = [x, a2] : (a1:as) : cycles

-- mismatched n = filter (\(a, b, phiAB) -> countTwoCycles b /= countTwoCycles phiAB) $ applyToAll n

-- applyToAll n = [(a, fromWord b, phi a $ fromWord b) | a <- [1..n+1], b <- permutations [1..n]]
