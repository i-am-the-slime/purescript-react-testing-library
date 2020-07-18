module Test.Component.AjaxSimpleSpec where

import Prelude
import Data.Maybe (Maybe(..))
import React.TestingLibrary (describeComponent, fireEventClick, renderComponent)
import Test.Component.AjaxSimple (mkAjaxSimple)
import Test.Spec (Spec, it)
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
