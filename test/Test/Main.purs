module Test.Main where

import Prelude
import Data.Identity (Identity(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (un)
import Data.Time.Duration (Seconds(..), fromDuration)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (defaultConfig, runSpecT)

main ∷ Effect Unit
main = do
  specs <- discover "\\.*Spec"
  runSpecT config [ consoleReporter ] specs
    # un Identity
    # launchAff_
  where
  config =
    defaultConfig
      { slow = 5.0 # Seconds # fromDuration
      , timeout = Nothing
      }
