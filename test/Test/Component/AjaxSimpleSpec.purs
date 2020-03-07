module Test.Component.AjaxSimpleSpec where

import Prelude
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import React.TestingLibrary (cleanup, fireEventClick, renderComponent, describeComponent)
import Test.Component.AjaxSimple (mkAjaxSimple)
import Test.Spec (Spec, after_, describe, it)
import Test.Spec.Assertions.DOM (textContentShouldEqual)

spec ∷ Spec Unit
spec =
  describeComponent (mkAjaxSimple (pure (Just 17))) "A component that makes AJAX calls" do
    it "can be mocked if designed accordingly" \ajaxSimple -> do
      { findByLabelText, findByTestId } <- renderComponent ajaxSimple {}
      button <- findByLabelText "Get User"
      fireEventClick button
      userIdElem <- findByTestId (_ == "userId")
      userIdElem `textContentShouldEqual` "17"
