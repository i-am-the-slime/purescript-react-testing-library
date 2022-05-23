module React.TestingLibrary
  ( FakeKeyboardEvent
  , RenderQueries
  , class TextMatch
  , cleanup
  , defaultKeyboardEvent
  , describeComponent
  , findByText
  , fireEvent
  , fireEventAbort
  , fireEventAnimationEnd
  , fireEventAnimationIteration
  , fireEventAnimationStart
  , fireEventBlur
  , fireEventCanPlay
  , fireEventCanPlayThrough
  , fireEventChange
  , fireEventClick
  , fireEventCompositionEnd
  , fireEventCompositionStart
  , fireEventCompositionUpdate
  , fireEventContextMenu
  , fireEventCopy
  , fireEventCut
  , fireEventDblClick
  , fireEventDoubleClick
  , fireEventDrag
  , fireEventDragEnd
  , fireEventDragEnter
  , fireEventDragExit
  , fireEventDragLeave
  , fireEventDragOver
  , fireEventDragStart
  , fireEventDrop
  , fireEventDurationChange
  , fireEventEmptied
  , fireEventEncrypted
  , fireEventEnded
  , fireEventError
  , fireEventFocus
  , fireEventFocusIn
  , fireEventFocusOut
  , fireEventGotPointerCapture
  , fireEventInput
  , fireEventInvalid
  , fireEventKeyDown
  , fireEventKeyPress
  , fireEventKeyUp
  , fireEventLoad
  , fireEventLoadStart
  , fireEventLoadedData
  , fireEventLoadedMetadata
  , fireEventLostPointerCapture
  , fireEventMouseDown
  , fireEventMouseEnter
  , fireEventMouseLeave
  , fireEventMouseMove
  , fireEventMouseOut
  , fireEventMouseOver
  , fireEventMouseUp
  , fireEventPaste
  , fireEventPause
  , fireEventPlay
  , fireEventPlaying
  , fireEventPointerCancel
  , fireEventPointerDown
  , fireEventPointerEnter
  , fireEventPointerLeave
  , fireEventPointerMove
  , fireEventPointerOut
  , fireEventPointerOver
  , fireEventPointerUp
  , fireEventProgress
  , fireEventRateChange
  , fireEventScroll
  , fireEventSeeked
  , fireEventSeeking
  , fireEventSelect
  , fireEventStalled
  , fireEventSubmit
  , fireEventSuspend
  , fireEventTimeUpdate
  , fireEventTouchCancel
  , fireEventTouchEnd
  , fireEventTouchMove
  , fireEventTouchStart
  , fireEventTransitionEnd
  , fireEventVolumeChange
  , fireEventWaiting
  , fireEventWheel
  , render
  , renderComponent
  , typeText
  ) where

import Prelude

import Control.Promise (Promise, toAff, toAffE)
import Control.Promise as Promise
import Data.Function.Uncurried (Fn1, Fn3, runFn1, runFn3)
import Data.Identity (Identity)
import Data.Maybe (Maybe(..))
import Data.String.Regex (Regex)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Foreign (Foreign, unsafeToForeign)
import Prim.TypeError (class Fail, Text)
import React.Basic (JSX, ReactComponent, element)
import Test.Spec (Spec, SpecT, after_, before, describe)
import Unsafe.Coerce (unsafeCoerce)
import Web.Event.Internal.Types (Event)
import Web.HTML (HTMLElement)

type RenderQueriesJS =
  { findByLabelText ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByLabelText ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByTestId ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByTestId ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByAltText ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByAltText ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByText ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByText ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByTitle ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByTitle ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByDisplayValue ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByDisplayValue ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByRole ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByRole ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , findByPlaceholderText ∷ Fn1 Foreign (Promise HTMLElement)
  , findAllByPlaceholderText ∷ Fn1 Foreign (Promise (Array HTMLElement))
  , queryByLabelText ∷ Fn1 Foreign HTMLElement
  , queryAllByLabelText ∷ Fn1 Foreign (Array HTMLElement)
  , queryByTestId ∷ Fn1 Foreign HTMLElement
  , queryAllByTestId ∷ Fn1 Foreign (Array HTMLElement)
  , queryByAltText ∷ Fn1 Foreign HTMLElement
  , queryAllByAltText ∷ Fn1 Foreign (Array HTMLElement)
  , queryByText ∷ Fn1 Foreign HTMLElement
  , queryAllByText ∷ Fn1 Foreign (Array HTMLElement)
  , queryByTitle ∷ Fn1 Foreign HTMLElement
  , queryAllByTitle ∷ Fn1 Foreign (Array HTMLElement)
  , queryByDisplayValue ∷ Fn1 Foreign HTMLElement
  , queryAllByDisplayValue ∷ Fn1 Foreign (Array HTMLElement)
  , queryByRole ∷ Fn1 Foreign HTMLElement
  , queryAllByRole ∷ Fn1 Foreign (Array HTMLElement)
  , queryByPlaceholderText ∷ Fn1 Foreign HTMLElement
  , queryAllByPlaceholderText ∷ Fn1 Foreign (Array HTMLElement)
  , rerender ∷ EffectFn1 JSX Unit
  }

type RenderQueries =
  { findByLabelText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByLabelText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByTestId ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByTestId ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByAltText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByAltText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByTitle ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByTitle ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByRole ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByRole ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , findByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
  , findAllByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
  , queryByLabelText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByLabelText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByTestId ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByTestId ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByAltText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByAltText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByTitle ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByTitle ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByRole ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByRole ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , queryByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
  , queryAllByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
  , rerender ∷ ∀ m. MonadEffect m => JSX -> m Unit
  }

foreign import cleanupImpl ∷ Effect Unit

cleanup ∷ Aff Unit
cleanup = liftEffect $ cleanupImpl

--| Example use:
--| ```purescript
--| spec = describeComponent mkMyComponent "My Component" do
--|  it "renders" \myComponent ->
--|    { findByText } <- renderComponent myComponent { someProp: "test text"}
--|    result <- findByText "test text"
--|    result `textContentShouldEqual` "I am rendering test text"
--| ```
describeComponent
  ∷ ∀ props
   . (Effect (ReactComponent props))
  -> String
  -> SpecT Aff (ReactComponent props) Identity Unit
  -> Spec Unit
describeComponent setup description test = after_ cleanup (before (liftEffect setup) (describe description test))

runToAff1 ∷ ∀ a b. (a -> Promise b) -> a -> Aff b
runToAff1 = map toAff <$> runFn1

toRenderQueries ∷ RenderQueriesJS -> RenderQueries
toRenderQueries rq =
  { findByLabelText: map unsafeCoerce runToAff1 rq.findByLabelText
  , findAllByLabelText: map unsafeCoerce runToAff1 rq.findAllByLabelText
  , findByTestId: map unsafeCoerce runToAff1 rq.findByTestId
  , findAllByTestId: map unsafeCoerce runToAff1 rq.findAllByTestId
  , findByAltText: map unsafeCoerce runToAff1 rq.findByAltText
  , findAllByAltText: map unsafeCoerce runToAff1 rq.findAllByAltText
  , findByText: map unsafeCoerce runToAff1 rq.findByText
  , findAllByText: map unsafeCoerce runToAff1 rq.findAllByText
  , findByTitle: map unsafeCoerce runToAff1 rq.findByTitle
  , findAllByTitle: map unsafeCoerce runToAff1 rq.findAllByTitle
  , findByDisplayValue: map unsafeCoerce runToAff1 rq.findByDisplayValue
  , findAllByDisplayValue: map unsafeCoerce runToAff1 rq.findAllByDisplayValue
  , findByRole: map unsafeCoerce runToAff1 rq.findByRole
  , findAllByRole: map unsafeCoerce runToAff1 rq.findAllByRole
  , findByPlaceholderText: map unsafeCoerce runToAff1 rq.findByPlaceholderText
  , findAllByPlaceholderText: map unsafeCoerce runToAff1 rq.findAllByPlaceholderText
  , queryByLabelText: map unsafeCoerce runFn1 (query rq.queryByLabelText)
  , queryAllByLabelText: map unsafeCoerce runFn1 (query rq.queryAllByLabelText)
  , queryByTestId: map unsafeCoerce runFn1 (query rq.queryByTestId)
  , queryAllByTestId: map unsafeCoerce runFn1 (query rq.queryAllByTestId)
  , queryByAltText: map unsafeCoerce runFn1 (query rq.queryByAltText)
  , queryAllByAltText: map unsafeCoerce runFn1 (query rq.queryAllByAltText)
  , queryByText: map unsafeCoerce runFn1 (query rq.queryByText)
  , queryAllByText: map unsafeCoerce runFn1 (query rq.queryAllByText)
  , queryByTitle: map unsafeCoerce runFn1 (query rq.queryByTitle)
  , queryAllByTitle: map unsafeCoerce runFn1 (query rq.queryAllByTitle)
  , queryByDisplayValue: map unsafeCoerce runFn1 (query rq.queryByDisplayValue)
  , queryAllByDisplayValue: map unsafeCoerce runFn1 (query rq.queryAllByDisplayValue)
  , queryByRole: map unsafeCoerce runFn1 (query rq.queryByRole)
  , queryAllByRole: map unsafeCoerce runFn1 (query rq.queryAllByRole)
  , queryByPlaceholderText: map unsafeCoerce runFn1 (query rq.queryByPlaceholderText)
  , queryAllByPlaceholderText: map unsafeCoerce runFn1 (query rq.queryAllByPlaceholderText)
  , rerender: liftRunEffectFn1 rq.rerender
  }

foreign import renderImpl ∷ EffectFn1 JSX RenderQueriesJS

-- | Renders some JSX
render ∷ ∀ m. MonadEffect m => JSX -> m RenderQueries
render jsx = liftRunEffectFn1 renderImpl jsx <#> toRenderQueries

renderComponent ∷ ∀ m p. MonadEffect m => ReactComponent { | p } -> { | p } -> m RenderQueries
renderComponent component props = element component props # render

foreign import findByTextImpl ∷ EffectFn2 HTMLElement String (Promise HTMLElement)

findByText ∷ HTMLElement -> String -> Aff HTMLElement
findByText el str = toAffE (runEffectFn2 findByTextImpl el str)

foreign import queryImpl ∷ ∀ a. (∀ x. x -> Maybe x) -> (∀ x. Maybe x) -> (Fn1 Foreign a) -> Foreign -> Maybe a

query ∷ ∀ a. (Fn1 Foreign a) -> Foreign -> Maybe a
query = queryImpl Just Nothing

foreign import fireEventImpl ∷ EffectFn2 HTMLElement Event Unit

fireEvent ∷ ∀ m. MonadEffect m => HTMLElement -> Event -> m Unit
fireEvent = liftRunEffectFn2 fireEventImpl

foreign import fireEventCopyImpl ∷ EffectFn1 HTMLElement Unit

fireEventCopy ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventCopy = liftRunEffectFn1 fireEventCopyImpl

foreign import fireEventCutImpl ∷ EffectFn1 HTMLElement Unit

fireEventCut ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventCut = liftRunEffectFn1 fireEventCutImpl

foreign import fireEventPasteImpl ∷ EffectFn1 HTMLElement Unit

fireEventPaste ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPaste = liftRunEffectFn1 fireEventPasteImpl

foreign import fireEventCompositionEndImpl ∷ EffectFn2 HTMLElement Foreign Unit

fireEventCompositionEnd ∷ ∀ m. MonadEffect m => String -> HTMLElement -> m Unit
fireEventCompositionEnd str el = liftRunEffectFn2 fireEventCompositionEndImpl el (unsafeToForeign { data: str })

foreign import fireEventCompositionStartImpl ∷ EffectFn2 HTMLElement Foreign Unit

fireEventCompositionStart ∷ ∀ m. MonadEffect m => String -> HTMLElement -> m Unit
fireEventCompositionStart str el = liftRunEffectFn2 fireEventCompositionStartImpl el (unsafeToForeign { data: str })

foreign import fireEventCompositionUpdateImpl ∷ EffectFn2 HTMLElement Foreign Unit

fireEventCompositionUpdate ∷ ∀ m. MonadEffect m => String -> HTMLElement -> m Unit
fireEventCompositionUpdate str el = liftRunEffectFn2 fireEventCompositionUpdateImpl el (unsafeToForeign { data: str })

type FakeKeyboardEvent =
  { altKey ∷ Boolean
  , charCode ∷ Int
  , ctrlKey ∷ Boolean
  , key ∷ String
  , keyCode ∷ Int
  , location ∷ Number
  , which ∷ Int
  , metaKey ∷ Boolean
  , repeat ∷ Boolean
  , shiftKey ∷ Boolean
  }

defaultKeyboardEvent ∷ FakeKeyboardEvent
defaultKeyboardEvent =
  { altKey: false
  , charCode: 0
  , ctrlKey: false
  , key: " "
  , keyCode: 0
  , location: 0.0
  , which: 0
  , metaKey: false
  , repeat: false
  , shiftKey: false
  }

foreign import fireEventKeyDownImpl ∷ EffectFn2 HTMLElement FakeKeyboardEvent Unit

fireEventKeyDown ∷ ∀ m. MonadEffect m => FakeKeyboardEvent -> HTMLElement -> m Unit
fireEventKeyDown = flip $ liftRunEffectFn2 fireEventKeyDownImpl

foreign import fireEventKeyUpImpl ∷ EffectFn2 HTMLElement FakeKeyboardEvent Unit

fireEventKeyUp ∷ ∀ m. MonadEffect m => FakeKeyboardEvent -> HTMLElement -> m Unit
fireEventKeyUp = flip $ liftRunEffectFn2 fireEventKeyUpImpl

foreign import fireEventKeyPressImpl ∷ EffectFn2 HTMLElement FakeKeyboardEvent Unit

fireEventKeyPress ∷ ∀ m. MonadEffect m => FakeKeyboardEvent -> HTMLElement -> m Unit
fireEventKeyPress = flip $ liftRunEffectFn2 fireEventKeyDownImpl

foreign import fireEventFocusImpl ∷ EffectFn1 HTMLElement Unit

fireEventFocus ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventFocus = liftRunEffectFn1 fireEventFocusImpl

foreign import fireEventBlurImpl ∷ EffectFn1 HTMLElement Unit

fireEventBlur ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventBlur = liftRunEffectFn1 fireEventBlurImpl

foreign import fireEventFocusInImpl ∷ EffectFn1 HTMLElement Unit

fireEventFocusIn ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventFocusIn = liftRunEffectFn1 fireEventFocusInImpl

foreign import fireEventFocusOutImpl ∷ EffectFn1 HTMLElement Unit

fireEventFocusOut ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventFocusOut = liftRunEffectFn1 fireEventFocusOutImpl

foreign import fireEventChangeImpl ∷ EffectFn2 HTMLElement Foreign Unit

fireEventChange ∷ ∀ r m. MonadEffect m => { | r } -> HTMLElement -> m Unit
fireEventChange ev = flip (liftRunEffectFn2 fireEventChangeImpl) (unsafeToForeign ev)

foreign import fireEventInputImpl ∷ EffectFn2 HTMLElement Foreign Unit

fireEventInput ∷ ∀ m. MonadEffect m => HTMLElement -> String -> m Unit
fireEventInput el value = liftRunEffectFn2 fireEventInputImpl el (unsafeToForeign { target: { value } })

foreign import fireEventInvalidImpl ∷ EffectFn1 HTMLElement Unit

fireEventInvalid ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventInvalid = liftRunEffectFn1 fireEventInvalidImpl

foreign import fireEventSubmitImpl ∷ EffectFn1 HTMLElement Unit

fireEventSubmit ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventSubmit = liftRunEffectFn1 fireEventSubmitImpl

foreign import fireEventClickImpl ∷ EffectFn1 HTMLElement Unit

fireEventClick ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventClick = liftRunEffectFn1 fireEventClickImpl

foreign import fireEventContextMenuImpl ∷ EffectFn1 HTMLElement Unit

fireEventContextMenu ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventContextMenu = liftRunEffectFn1 fireEventContextMenuImpl

foreign import fireEventDblClickImpl ∷ EffectFn1 HTMLElement Unit

fireEventDblClick ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDblClick = liftRunEffectFn1 fireEventDblClickImpl

foreign import fireEventDragImpl ∷ EffectFn1 HTMLElement Unit

fireEventDrag ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDrag = liftRunEffectFn1 fireEventDragImpl

foreign import fireEventDragEndImpl ∷ EffectFn1 HTMLElement Unit

fireEventDragEnd ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDragEnd = liftRunEffectFn1 fireEventDragEndImpl

foreign import fireEventDragEnterImpl ∷ EffectFn1 HTMLElement Unit

fireEventDragEnter ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDragEnter = liftRunEffectFn1 fireEventDragEnterImpl

foreign import fireEventDragExitImpl ∷ EffectFn1 HTMLElement Unit

fireEventDragExit ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDragExit = liftRunEffectFn1 fireEventDragExitImpl

foreign import fireEventDragLeaveImpl ∷ EffectFn1 HTMLElement Unit

fireEventDragLeave ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDragLeave = liftRunEffectFn1 fireEventDragLeaveImpl

foreign import fireEventDragOverImpl ∷ EffectFn1 HTMLElement Unit

fireEventDragOver ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDragOver = liftRunEffectFn1 fireEventDragOverImpl

foreign import fireEventDragStartImpl ∷ EffectFn1 HTMLElement Unit

fireEventDragStart ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDragStart = liftRunEffectFn1 fireEventDragStartImpl

foreign import fireEventDropImpl ∷ EffectFn1 HTMLElement Unit

fireEventDrop ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDrop = liftRunEffectFn1 fireEventDropImpl

foreign import fireEventMouseDownImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseDown ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseDown = liftRunEffectFn1 fireEventMouseDownImpl

foreign import fireEventMouseEnterImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseEnter ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseEnter = liftRunEffectFn1 fireEventMouseEnterImpl

foreign import fireEventMouseLeaveImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseLeave ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseLeave = liftRunEffectFn1 fireEventMouseLeaveImpl

foreign import fireEventMouseMoveImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseMove ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseMove = liftRunEffectFn1 fireEventMouseMoveImpl

foreign import fireEventMouseOutImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseOut ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseOut = liftRunEffectFn1 fireEventMouseOutImpl

foreign import fireEventMouseOverImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseOver ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseOver = liftRunEffectFn1 fireEventMouseOverImpl

foreign import fireEventMouseUpImpl ∷ EffectFn1 HTMLElement Unit

fireEventMouseUp ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventMouseUp = liftRunEffectFn1 fireEventMouseUpImpl

foreign import fireEventSelectImpl ∷ EffectFn1 HTMLElement Unit

fireEventSelect ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventSelect = liftRunEffectFn1 fireEventSelectImpl

foreign import fireEventTouchCancelImpl ∷ EffectFn1 HTMLElement Unit

fireEventTouchCancel ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventTouchCancel = liftRunEffectFn1 fireEventTouchCancelImpl

foreign import fireEventTouchEndImpl ∷ EffectFn1 HTMLElement Unit

fireEventTouchEnd ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventTouchEnd = liftRunEffectFn1 fireEventTouchEndImpl

foreign import fireEventTouchMoveImpl ∷ EffectFn1 HTMLElement Unit

fireEventTouchMove ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventTouchMove = liftRunEffectFn1 fireEventTouchMoveImpl

foreign import fireEventTouchStartImpl ∷ EffectFn1 HTMLElement Unit

fireEventTouchStart ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventTouchStart = liftRunEffectFn1 fireEventTouchStartImpl

foreign import fireEventScrollImpl ∷ EffectFn1 HTMLElement Unit

fireEventScroll ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventScroll = liftRunEffectFn1 fireEventScrollImpl

foreign import fireEventWheelImpl ∷ EffectFn1 HTMLElement Unit

fireEventWheel ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventWheel = liftRunEffectFn1 fireEventWheelImpl

foreign import fireEventAbortImpl ∷ EffectFn1 HTMLElement Unit

fireEventAbort ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventAbort = liftRunEffectFn1 fireEventAbortImpl

foreign import fireEventCanPlayImpl ∷ EffectFn1 HTMLElement Unit

fireEventCanPlay ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventCanPlay = liftRunEffectFn1 fireEventCanPlayImpl

foreign import fireEventCanPlayThroughImpl ∷ EffectFn1 HTMLElement Unit

fireEventCanPlayThrough ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventCanPlayThrough = liftRunEffectFn1 fireEventCanPlayThroughImpl

foreign import fireEventDurationChangeImpl ∷ EffectFn1 HTMLElement Unit

fireEventDurationChange ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDurationChange = liftRunEffectFn1 fireEventDurationChangeImpl

foreign import fireEventEmptiedImpl ∷ EffectFn1 HTMLElement Unit

fireEventEmptied ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventEmptied = liftRunEffectFn1 fireEventEmptiedImpl

foreign import fireEventEncryptedImpl ∷ EffectFn1 HTMLElement Unit

fireEventEncrypted ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventEncrypted = liftRunEffectFn1 fireEventEncryptedImpl

foreign import fireEventEndedImpl ∷ EffectFn1 HTMLElement Unit

fireEventEnded ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventEnded = liftRunEffectFn1 fireEventEndedImpl

foreign import fireEventLoadedDataImpl ∷ EffectFn1 HTMLElement Unit

fireEventLoadedData ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventLoadedData = liftRunEffectFn1 fireEventLoadedDataImpl

foreign import fireEventLoadedMetadataImpl ∷ EffectFn1 HTMLElement Unit

fireEventLoadedMetadata ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventLoadedMetadata = liftRunEffectFn1 fireEventLoadedMetadataImpl

foreign import fireEventLoadStartImpl ∷ EffectFn1 HTMLElement Unit

fireEventLoadStart ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventLoadStart = liftRunEffectFn1 fireEventLoadStartImpl

foreign import fireEventPauseImpl ∷ EffectFn1 HTMLElement Unit

fireEventPause ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPause = liftRunEffectFn1 fireEventPauseImpl

foreign import fireEventPlayImpl ∷ EffectFn1 HTMLElement Unit

fireEventPlay ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPlay = liftRunEffectFn1 fireEventPlayImpl

foreign import fireEventPlayingImpl ∷ EffectFn1 HTMLElement Unit

fireEventPlaying ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPlaying = liftRunEffectFn1 fireEventPlayingImpl

foreign import fireEventProgressImpl ∷ EffectFn1 HTMLElement Unit

fireEventProgress ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventProgress = liftRunEffectFn1 fireEventProgressImpl

foreign import fireEventRateChangeImpl ∷ EffectFn1 HTMLElement Unit

fireEventRateChange ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventRateChange = liftRunEffectFn1 fireEventRateChangeImpl

foreign import fireEventSeekedImpl ∷ EffectFn1 HTMLElement Unit

fireEventSeeked ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventSeeked = liftRunEffectFn1 fireEventSeekedImpl

foreign import fireEventSeekingImpl ∷ EffectFn1 HTMLElement Unit

fireEventSeeking ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventSeeking = liftRunEffectFn1 fireEventSeekingImpl

foreign import fireEventStalledImpl ∷ EffectFn1 HTMLElement Unit

fireEventStalled ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventStalled = liftRunEffectFn1 fireEventStalledImpl

foreign import fireEventSuspendImpl ∷ EffectFn1 HTMLElement Unit

fireEventSuspend ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventSuspend = liftRunEffectFn1 fireEventSuspendImpl

foreign import fireEventTimeUpdateImpl ∷ EffectFn1 HTMLElement Unit

fireEventTimeUpdate ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventTimeUpdate = liftRunEffectFn1 fireEventTimeUpdateImpl

foreign import fireEventVolumeChangeImpl ∷ EffectFn1 HTMLElement Unit

fireEventVolumeChange ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventVolumeChange = liftRunEffectFn1 fireEventVolumeChangeImpl

foreign import fireEventWaitingImpl ∷ EffectFn1 HTMLElement Unit

fireEventWaiting ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventWaiting = liftRunEffectFn1 fireEventWaitingImpl

foreign import fireEventLoadImpl ∷ EffectFn1 HTMLElement Unit

fireEventLoad ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventLoad = liftRunEffectFn1 fireEventLoadImpl

foreign import fireEventErrorImpl ∷ EffectFn1 HTMLElement Unit

fireEventError ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventError = liftRunEffectFn1 fireEventErrorImpl

foreign import fireEventAnimationStartImpl ∷ EffectFn1 HTMLElement Unit

fireEventAnimationStart ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventAnimationStart = liftRunEffectFn1 fireEventAnimationStartImpl

foreign import fireEventAnimationEndImpl ∷ EffectFn1 HTMLElement Unit

fireEventAnimationEnd ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventAnimationEnd = liftRunEffectFn1 fireEventAnimationEndImpl

foreign import fireEventAnimationIterationImpl ∷ EffectFn1 HTMLElement Unit

fireEventAnimationIteration ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventAnimationIteration = liftRunEffectFn1 fireEventAnimationIterationImpl

foreign import fireEventTransitionEndImpl ∷ EffectFn1 HTMLElement Unit

fireEventTransitionEnd ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventTransitionEnd = liftRunEffectFn1 fireEventTransitionEndImpl

foreign import fireEventDoubleClickImpl ∷ EffectFn1 HTMLElement Unit

fireEventDoubleClick ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventDoubleClick = liftRunEffectFn1 fireEventDoubleClickImpl

foreign import fireEventPointerOverImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerOver ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerOver = liftRunEffectFn1 fireEventPointerOverImpl

foreign import fireEventPointerEnterImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerEnter ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerEnter = liftRunEffectFn1 fireEventPointerEnterImpl

foreign import fireEventPointerDownImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerDown ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerDown = liftRunEffectFn1 fireEventPointerDownImpl

foreign import fireEventPointerMoveImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerMove ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerMove = liftRunEffectFn1 fireEventPointerMoveImpl

foreign import fireEventPointerUpImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerUp ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerUp = liftRunEffectFn1 fireEventPointerUpImpl

foreign import fireEventPointerCancelImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerCancel ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerCancel = liftRunEffectFn1 fireEventPointerCancelImpl

foreign import fireEventPointerOutImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerOut ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerOut = liftRunEffectFn1 fireEventPointerOutImpl

foreign import fireEventPointerLeaveImpl ∷ EffectFn1 HTMLElement Unit

fireEventPointerLeave ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventPointerLeave = liftRunEffectFn1 fireEventPointerLeaveImpl

foreign import fireEventGotPointerCaptureImpl ∷ EffectFn1 HTMLElement Unit

fireEventGotPointerCapture ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventGotPointerCapture = liftRunEffectFn1 fireEventGotPointerCaptureImpl

foreign import fireEventLostPointerCaptureImpl ∷ EffectFn1 HTMLElement Unit

fireEventLostPointerCapture ∷ ∀ m. MonadEffect m => HTMLElement -> m Unit
fireEventLostPointerCapture = liftRunEffectFn1 fireEventLostPointerCaptureImpl

liftRunEffectFn1 ∷ ∀ m a b. MonadEffect m => EffectFn1 a b -> a -> m b
liftRunEffectFn1 = (map >>> map) liftEffect runEffectFn1

liftRunEffectFn2 ∷ ∀ m a b c. MonadEffect m => EffectFn2 a b c -> a -> b -> m c
liftRunEffectFn2 = (map >>> map >>> map) liftEffect runEffectFn2

-- | User Events
foreign import typeImpl ∷ Fn3 HTMLElement String Foreign (Effect (Promise Unit))

typeText ∷ String -> HTMLElement -> Aff Unit
typeText text el = Promise.toAffE $ runFn3 typeImpl el text (unsafeToForeign {})

-- | To be used for most of the getBy/findBy etc functions
class TextMatch ∷ ∀ k. k -> Constraint
class TextMatch a

instance tmString ∷ TextMatch String
else instance tmRegex ∷ TextMatch Regex
else instance tmFn ∷ TextMatch (String -> Boolean)
else instance tmInvalidType ∷
  ( Fail (Text "TextMatch must either be a String, a Regex, or String -> Boolean")
  ) =>
  TextMatch a
