module Test.Component.InputSpec where

import Prelude
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import React.Basic (ReactComponent)
import React.TestingLibrary (cleanup, renderComponent, typeText)
import Test.Component.Input (mkInput)
import Test.Spec (Spec, after_, before, describe, it)
import Test.Spec.Assertions.DOM (textContentShouldEqual, valueShouldEqual)
import Web.HTML.HTMLElement (focus)

spec ∷ Spec Unit
spec =
  after_ cleanup
    $ before setup
    $ describe
        "A simple input" do
        it
          "renders without errors" \inp -> do
          { findByLabelText } <- renderComponent inp {}
          elem <- findByLabelText "Some input"
          elem `textContentShouldEqual` ""
        it
          "sets text when typed" \inp -> do
          { findByLabelText } <- renderComponent inp {}
          elem <- findByLabelText "Some input"
          elem `textContentShouldEqual` ""
          focus elem # liftEffect
          typeText "Dornenvögel" elem
          elem `valueShouldEqual` "Dornenvögel"

setup ∷ Aff (ReactComponent {})
setup = mkInput # liftEffect
