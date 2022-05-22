module Test.Component.CounterSpec where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Ref (modify, new, read)
import React.Basic (ReactComponent, element)
import React.TestingLibrary (cleanup, fireEventClick, renderComponent)
import Test.Component.Counter (mkCounter)
import Test.Spec (Spec, after_, before, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Assertions.DOM (textContentShouldEqual)

spec ∷ Spec Unit
spec =
  after_ cleanup
    $ before setup
    $ describe
        "A simple counter" do
        it
          "renders without errors" \counter -> do
          rendersRef <- liftEffect do new 0
          let onRender = void $ modify (1 + _) rendersRef
          { findByLabelText, rerender } <- renderComponent counter { onRender }
          elem1 <- findByLabelText "A simple counter"
          rerender (element counter { onRender })
          elem2 <- findByLabelText "A simple counter"
          elem1 `textContentShouldEqual` "Increment: 0"
          elem2 `textContentShouldEqual` "Increment: 0"
          renders <- liftEffect do read rendersRef
          renders `shouldEqual` 2
        it
          "increments when clicked" \counter -> do
          rendersRef <- liftEffect do new 0
          let onRender = void $ modify (1 + _) rendersRef
          { findByLabelText, rerender } <- renderComponent counter { onRender }
          elem <- findByLabelText "A simple counter"
          elem `textContentShouldEqual` "Increment: 0"
          fireEventClick elem
          elem `textContentShouldEqual` "Increment: 1"
          renders1 <- liftEffect do read rendersRef
          renders1 `shouldEqual` 2
          rerender (element counter { onRender })
          rerender (element counter { onRender })
          renders2 <- liftEffect do read rendersRef
          renders2 `shouldEqual` 4

setup ∷ Aff (ReactComponent { onRender :: Effect Unit })
setup = mkCounter # liftEffect
