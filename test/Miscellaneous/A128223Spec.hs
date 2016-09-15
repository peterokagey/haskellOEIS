module Miscellaneous.A128223Spec (main, spec) where
import Test.Hspec
import Miscellaneous.A128223 (a128223)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A128223" $
    it "correctly computes the first 20 elements" $
      take 5 (map a128223 [0..]) `shouldBe` expectedValue where
        expectedValue = [0,1,3,7,10]