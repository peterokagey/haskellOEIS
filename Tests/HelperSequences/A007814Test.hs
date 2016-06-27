module Tests.HelperSequences.A007814Test where
import Test.Hspec
import HelperSequences.A007814 (a007814)
main :: IO ()

main = hspec $
  describe "A007814" $
    it "correctly computes the first 20 elements" $
      take 20 (map a007814 [1..]) `shouldBe` expectedValue where
        expectedValue = [0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,0,1,0,2]
