module Test.Spec.Assertions.DOM where

import Prelude
import Control.Monad.Error.Class (class MonadThrow)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error)
import Test.Spec.Assertions (shouldEqual)
import Web.DOM.Node (textContent)
import Web.HTML.HTMLElement (HTMLElement)
import Web.HTML.HTMLElement as HTMLElement

textContentShouldEqual ∷ ∀ m. Bind m => MonadEffect m => MonadThrow Error m => HTMLElement -> String -> m Unit
textContentShouldEqual elem str = do
  content <- liftEffect $ textContent $ (HTMLElement.toNode elem)
  content `shouldEqual` str
