module Test.Main where

import Prelude

import Effect (Effect)
import Test.Spec.Discovery (discoverAndRunSpecs)
import Test.Spec.Reporter.Console (consoleReporter)

-- NOTE: it will read tests from ./output/
main :: Effect Unit
main = discoverAndRunSpecs [ consoleReporter ] "Test\\..*Spec"
