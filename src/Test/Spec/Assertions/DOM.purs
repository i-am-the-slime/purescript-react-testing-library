module Test.Spec.Assertions.DOM where

import Prelude
import Control.Alt ((<|>))
import Control.Monad.Error.Class (class MonadThrow)
import Data.Maybe (Maybe(..))
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error)
import Test.Spec.Assertions (fail, shouldEqual)
import Web.DOM.Node (textContent)
import Web.HTML.HTMLButtonElement as Button
import Web.HTML.HTMLElement (HTMLElement)
import Web.HTML.HTMLElement as HTMLElement
import Web.HTML.HTMLInputElement as Input
import Web.HTML.HTMLSelectElement as Select
import Web.HTML.HTMLTextAreaElement as TextArea

textContentShouldEqual ∷ ∀ m. Bind m => MonadEffect m => MonadThrow Error m => HTMLElement -> String -> m Unit
textContentShouldEqual elem str = do
  content <- liftEffect $ textContent $ (HTMLElement.toNode elem)
  content `shouldEqual` str

valueShouldEqual ∷ HTMLElement -> String -> Aff Unit
valueShouldEqual elem str = do
  maybeValue <- maybeValueEffect # liftEffect
  case maybeValue of
    Just s -> s `shouldEqual` str
    Nothing -> fail "Element does not have a value property"
  where
  maybeValueEffect = do
    btn <- Button.fromHTMLElement elem # traverse Button.value
    inp <- Input.fromHTMLElement elem # traverse Input.value
    txt <- TextArea.fromHTMLElement elem # traverse TextArea.value
    sel <- Select.fromHTMLElement elem # traverse Select.value
    pure $ btn <|> inp <|> txt <|> sel
