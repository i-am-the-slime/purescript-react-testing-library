module Test.Component.AjaxSimpleSpec where

import Prelude
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import React.TestingLibrary (cleanup, fireEventClick, renderComponent)
import Test.Component.AjaxSimple (mkAjaxSimple)
import Test.Spec (Spec, after_, describe, it)
import Test.Spec.Assertions.DOM (textContentShouldEqual)

spec ∷ Spec Unit
spec =
  after_ cleanup do
    describe "A component that makes AJAX calls" do
      it "can be mocked if designed accordingly" do
        ajaxSimple <- liftEffect $ mkAjaxSimple $ pure $ Just 17
        { findByLabelText, findByTestId } <- renderComponent ajaxSimple {}
        button <- findByLabelText "Get User"
        fireEventClick button
        userIdElem <- findByTestId (_ == "userId")
        userIdElem `textContentShouldEqual` "17"
