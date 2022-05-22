module Test.Main where

import Prelude

import Data.Identity (Identity(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (un)
import Data.Time.Duration (Milliseconds(..), Seconds(..), fromDuration)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff as Aff
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (defaultConfig, runSpecT)

main ∷ Effect Unit
main = launchAff_ do
  specs <- discover "\\.*Spec"
  Aff.delay (1000.0 # Milliseconds)
  void $
    runSpecT
      config
      [ consoleReporter ]
      specs
      # un Identity
  where
  config =
    defaultConfig
      { slow = 5.0 # Seconds # fromDuration
      , timeout = Nothing
      }
