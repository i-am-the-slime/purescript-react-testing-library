module Test.Spec.Assertions.DOM where

import Prelude
import Control.Alt ((<|>))
import Control.Monad.Error.Class (class MonadThrow)
import Control.Monad.Maybe.Trans (MaybeT(..), runMaybeT)
import Data.Maybe (Maybe(..), isJust)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error)
import Test.Spec.Assertions (fail, shouldEqual)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM.Element as Element
import Web.DOM.Node (textContent)
import Web.DOM.Node as Node
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

shouldHaveAttribute ∷ HTMLElement -> String -> Aff Unit
shouldHaveAttribute x attr = do
  maybeAttrValue <- Element.getAttribute attr (HTMLElement.toElement x) # liftEffect
  unless (isJust maybeAttrValue) do
    fail $ "HTMLElement does not have attribute: " <> attr

shouldHaveAttributeWithValue ∷ HTMLElement -> String -> String -> Aff Unit
shouldHaveAttributeWithValue x attr value = do
  maybeAttrValue <- Element.getAttribute attr (HTMLElement.toElement x) # liftEffect
  case maybeAttrValue of
    Just v -> v `shouldEqual` value
    Nothing -> fail $ "HTMLElement does not have attribute: " <> attr

getParentOrFailWith ∷ String -> HTMLElement -> Aff HTMLElement
getParentOrFailWith failureMessage element =
  liftEffect do
    maybeP <-
      runMaybeT do
        let n = HTMLElement.toNode element
        p <- Node.parentElement n # MaybeT
        HTMLElement.fromElement p # pure # MaybeT
    case maybeP of
      Just p -> pure p
      Nothing -> do
        fail failureMessage
        unsafeCoerce unit
