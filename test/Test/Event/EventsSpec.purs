module Test.Event.EventsSpec where

import Prelude

import Data.Either (Either(..))
import Data.List.NonEmpty (NonEmptyList)
import Data.Maybe (Maybe(..))
import Data.Semigroup.Foldable (intercalateMap)
import Data.Symbol (class IsSymbol, reflectSymbol)
import Effect (Effect)
import Effect.AVar (AVar)
import Effect.Aff (Aff)
import Effect.Aff.AVar as AVar
import Effect.Class (class MonadEffect, liftEffect)
import Foreign (ForeignError(..), MultipleErrors, unsafeToForeign)
import Foreign.Object (Object)
import Prim.Row (class Cons, class Lacks, class Union)
import React.Basic (JSX, ReactComponent)
import React.Basic.DOM (CSS, Props_img, Props_div)
import React.Basic.DOM as R
import React.Basic.DOM.Events (compositionData)
import React.Basic.Events (EventFn, EventHandler, SyntheticEvent, syntheticEvent)
import React.TestingLibrary (class TextMatch, cleanup, defaultKeyboardEvent, fireEventAnimationEnd, fireEventAnimationIteration, fireEventAnimationStart, fireEventBlur, fireEventCanPlay, fireEventCanPlayThrough, fireEventClick, fireEventCompositionEnd, fireEventCompositionStart, fireEventCompositionUpdate, fireEventContextMenu, fireEventCopy, fireEventCut, fireEventDrag, fireEventDragEnd, fireEventDragEnter, fireEventDragExit, fireEventDragLeave, fireEventDragOver, fireEventDragStart, fireEventDrop, fireEventEmptied, fireEventEnded, fireEventFocus, fireEventInvalid, fireEventKeyDown, fireEventKeyUp, fireEventLoad, fireEventLoadedMetadata, fireEventMouseDown, fireEventMouseEnter, fireEventMouseLeave, fireEventMouseMove, fireEventMouseOut, fireEventMouseOver, fireEventMouseUp, fireEventPaste, fireEventPause, fireEventPlaying, fireEventPointerCancel, fireEventPointerDown, fireEventPointerMove, fireEventPointerOut, fireEventPointerOver, fireEventPointerUp, fireEventRateChange, fireEventSeeked, fireEventSelect, fireEventSubmit, fireEventSuspend, fireEventTouchCancel, fireEventTouchEnd, fireEventTouchMove, fireEventTouchStart, fireEventTransitionEnd, fireEventVolumeChange, fireEventWheel, renderComponent)
import Record (disjointUnion)
import Test.Event.Component (mkEventElem, mkEventImg, mkEventInput, on)
import Test.Spec (Spec, after_, describe, it)
import Test.Spec.Assertions (fail, shouldEqual)
import Type.Prelude (Proxy)
import Web.HTML (HTMLElement)
import Yoga.JSON (class ReadForeign, read)

spec ∷ Spec Unit
spec =
  after_ cleanup do
    describe "All exposed events work" do
      receivesEvent R.div on.blur fireEventBlur { type: "blur" }
      receivesEvent R.div on.click fireEventClick { type: "click", button: 0 }
      receivesEvent R.textarea on.focus fireEventFocus { type: "focus" }
      receivesEvent R.div on.mouseDown fireEventMouseDown { type: "mousedown" }
      receivesEvent R.div on.mouseEnter fireEventMouseEnter { type: "mouseenter" }
      receivesEvent R.div on.mouseLeave fireEventMouseLeave { type: "mouseleave" }
      receivesEvent R.div on.mouseMove fireEventMouseMove { type: "mousemove" }
      receivesEvent R.div on.mouseOut fireEventMouseOut { type: "mouseout" }
      receivesEvent R.div on.mouseOver fireEventMouseOver { type: "mouseover" }
      receivesEvent R.div on.copy fireEventCopy { type: "copy" }
      receivesEvent R.div on.cut fireEventCut { type: "cut" }
      receivesEvent R.div on.paste fireEventPaste { type: "paste" }
      receivesEventData R.div compositionData on.compositionStart (fireEventCompositionStart "start") (Just "start")
      receivesEvent R.div on.compositionStart (fireEventCompositionStart "") { type: "compositionstart", data: "" }
      receivesEvent R.div on.compositionUpdate (fireEventCompositionUpdate "update") { type: "compositionupdate", data: "update" }
      receivesEvent R.div on.compositionEnd (fireEventCompositionEnd "end") { type: "compositionend", data: "end" }
      receivesEvent R.div on.mouseUp fireEventMouseUp { type: "mouseup" }
      -- receivesEvent R.video on.abort fireEventAbort { type: "abort" }
      receivesEvent R.div on.animationEnd fireEventAnimationEnd { type: "animationend" }
      receivesEvent R.div on.animationIteration fireEventAnimationIteration { type: "animationiteration" }
      receivesEvent R.div on.animationStart fireEventAnimationStart { type: "animationstart" }
      receivesEvent R.div on.blur fireEventBlur { type: "blur" }
      receivesEvent R.audio on.canPlay fireEventCanPlay { type: "canplay" }
      receivesEvent R.audio on.canPlayThrough fireEventCanPlayThrough { type: "canplaythrough" }
      -- receivesEvent R.div on.change fireEventChange { type: "change" }
      receivesEvent R.div on.click fireEventClick { type: "click" }
      receivesEvent R.div on.contextMenu fireEventContextMenu { type: "contextmenu" }
      receivesEvent R.div on.copy fireEventCopy { type: "copy" }
      receivesEvent R.div on.cut fireEventCut { type: "cut" }
      -- receivesEvent R.div on.doubleClick fireEventDoubleClick { type: "doubleClick" }
      receivesEvent R.div on.drag fireEventDrag { type: "drag" }
      receivesEvent R.div on.dragEnd fireEventDragEnd { type: "dragend" }
      receivesEvent R.div on.dragEnter fireEventDragEnter { type: "dragenter" }
      receivesEvent R.div on.dragExit fireEventDragExit { type: "dragexit" }
      receivesEvent R.div on.dragLeave fireEventDragLeave { type: "dragleave" }
      receivesEvent R.div on.dragOver fireEventDragOver { type: "dragover" }
      receivesEvent R.div on.dragStart fireEventDragStart { type: "dragstart" }
      receivesEvent R.div on.drop fireEventDrop { type: "drop" }
      -- receivesEvent R.video on.durationChange fireEventDurationChange { type: "durationchange" }
      receivesEvent R.audio on.emptied fireEventEmptied { type: "emptied" }
      -- receivesEvent R.video on.encrypted fireEventEncrypted { type: "encrypted" }
      receivesEvent R.audio on.ended fireEventEnded { type: "ended" }
      -- receivesEvent R.video on.error fireEventError { type: "error" }
      receivesEvent R.div on.focus fireEventFocus { type: "focus" }
      receivesEventInput on.invalid fireEventInvalid { type: "invalid" }
      receivesEventImg on.load fireEventLoad { type: "load" }
      -- receivesEvent R.video on.loadedData fireEventLoadedData { type: "loadeddata" }
      receivesEvent R.audio on.loadedMetadata fireEventLoadedMetadata { type: "loadedmetadata" }
      -- receivesEvent R.video on.loadStart fireEventLoadStart { type: "loadstart" }
      receivesEvent R.div on.mouseDown fireEventMouseDown { type: "mousedown" }
      receivesEvent R.div on.mouseEnter fireEventMouseEnter { type: "mouseenter" }
      receivesEvent R.div on.mouseLeave fireEventMouseLeave { type: "mouseleave" }
      receivesEvent R.div on.mouseMove fireEventMouseMove { type: "mousemove" }
      receivesEvent R.div on.mouseOut fireEventMouseOut { type: "mouseout" }
      receivesEvent R.div on.mouseOver fireEventMouseOver { type: "mouseover" }
      receivesEvent R.div on.mouseUp fireEventMouseUp { type: "mouseup" }
      receivesEvent R.div on.paste fireEventPaste { type: "paste" }
      receivesEvent R.audio on.pause fireEventPause { type: "pause" }
      -- receivesEvent R.video on.play fireEventPlay { type: "play" }
      receivesEvent R.audio on.playing fireEventPlaying { type: "playing" }
      receivesEvent R.div on.pointerCancel fireEventPointerCancel { type: "pointercancel" }
      receivesEvent R.div on.pointerDown fireEventPointerDown { type: "pointerdown" }
      receivesEvent R.div on.pointerMove fireEventPointerMove { type: "pointermove" }
      receivesEvent R.div on.pointerOut fireEventPointerOut { type: "pointerout" }
      receivesEvent R.div on.pointerOver fireEventPointerOver { type: "pointerover" }
      receivesEvent R.div on.pointerUp fireEventPointerUp { type: "pointerup" }
      -- receivesEvent R.video on.progress fireEventProgress { type: "progress" }
      receivesEvent R.audio on.rateChange fireEventRateChange { type: "ratechange" }
      -- receivesEvent R.video on.scroll fireEventScroll { type: "scroll" }
      receivesEvent R.audio on.seeked fireEventSeeked { type: "seeked" }
      -- receivesEvent R.video on.seeking fireEventSeeking { type: "seeking" }
      receivesEventInput on.select fireEventSelect { type: "select" }
      -- receivesEvent R.video on.stalled fireEventStalled { type: "stalled" }
      receivesEvent R.form on.submit fireEventSubmit { type: "submit" }
      receivesEvent R.audio on.suspend fireEventSuspend { type: "suspend" }
      -- receivesEvent R.video on.timeUpdate fireEventTimeUpdate { type: "timeupdate" }
      receivesEvent R.div on.touchCancel fireEventTouchCancel { type: "touchcancel" }
      receivesEvent R.div on.touchEnd fireEventTouchEnd { type: "touchend" }
      receivesEvent R.div on.touchMove fireEventTouchMove { type: "touchmove" }
      receivesEvent R.div on.touchStart fireEventTouchStart { type: "touchstart" }
      receivesEvent R.div on.transitionEnd fireEventTransitionEnd { type: "transitionend" }
      receivesEvent R.audio on.volumeChange fireEventVolumeChange { type: "volumechange" }
      -- receivesEvent R.video on.waiting fireEventWaiting { type: "waiting" }
      receivesEvent R.div on.wheel fireEventWheel { type: "wheel" }
      receivesEvent R.div on.keyDown (fireEventKeyDown defaultKeyboardEvent) (defaultKeyboardEvent `disjointUnion` { type: "keydown" })
      receivesEvent R.div on.keyUp (fireEventKeyUp defaultKeyboardEvent) (defaultKeyboardEvent `disjointUnion` { type: "keyup" })

checkWithVar ∷ ∀ a b. Show a => Eq a => a -> (AVar (Either (NonEmptyList ForeignError) (Maybe a)) -> Aff b) -> Aff Unit
checkWithVar expected calc = do
  var <- AVar.empty
  _comp <- calc var
  result <- AVar.tryRead var
  case result of
    Nothing -> fail $ "\tVariable not written\n\n"
    Just (Left broken) -> fail $ "\n\tEvent is malformed:\n\n\t" <> (printErrors broken) <> "\n"
    Just (Right actual) -> actual `shouldEqual` Just expected

renderAndCheck
  ∷ ∀ t100 t119 t74 t84
   . IsSymbol t74
  => Discard t100
  => Show t119
  => Eq t119
  => Proxy t74
  -> ((t84 -> Aff Unit) -> Effect (ReactComponent (Record ())))
  -> (t84 -> Either (NonEmptyList ForeignError) (Maybe t119))
  -> ( { findAllByAltText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByLabelText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByRole ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByTestId ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByText ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findAllByTitle ∷ ∀ tm. TextMatch tm => tm -> Aff (Array HTMLElement)
       , findByAltText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByLabelText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByRole ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByTestId ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByText ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , findByTitle ∷ ∀ tm. TextMatch tm => tm -> Aff HTMLElement
       , queryAllByAltText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByLabelText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByRole ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByTestId ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByText ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryAllByTitle ∷ ∀ tm. TextMatch tm => tm -> Maybe (Array HTMLElement)
       , queryByAltText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByDisplayValue ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByLabelText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByPlaceholderText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByRole ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByTestId ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByText ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , queryByTitle ∷ ∀ tm. TextMatch tm => tm -> Maybe HTMLElement
       , rerender ∷ ∀ m. MonadEffect m => JSX -> m Unit
       }
       -> Aff t100
     )
  -> t119
  -> Spec Unit
renderAndCheck event mkComp toSave check expected =
  it (reflectSymbol event) do
    var <- AVar.empty
    comp <- mkComp (\x -> var # AVar.put (toSave x)) # liftEffect
    cleanup
    helpers <- renderComponent comp {}
    check helpers
    result <- AVar.read var
    case result of
      Left broken -> fail $ "\n\tEvent is malformed:\n\n\t" <> (printErrors broken) <> "\n"
      Right actual -> actual `shouldEqual` Just expected

receivesEvent
  ∷ ∀ a props elem
   . IsSymbol elem
  => Show a
  => Eq a
  => Cons elem EventHandler (_data ∷ Object String, style ∷ CSS) props
  => Lacks elem (_data ∷ Object String, style ∷ CSS)
  => ReadForeign a
  => (Record props -> JSX)
  -> Proxy elem
  -> (HTMLElement -> Aff Unit)
  -> a
  -> Spec Unit
receivesEvent elem event fire =
  renderAndCheck
    event
    (mkEventElem elem event syntheticEvent)
    (read <<< unsafeToForeign)
    (\{ findByTestId } -> findByTestId "event-component" >>= fire)

receivesEventImg
  ∷ ∀ a props props_ elem
   . IsSymbol elem
  => Show a
  => Eq a
  => Cons elem EventHandler (alt ∷ String, tabIndex ∷ Int) props
  => Lacks elem (alt ∷ String, tabIndex ∷ Int)
  => Union props props_ Props_img
  => ReadForeign a
  => Proxy elem
  -> (HTMLElement -> Aff Unit)
  -> a
  -> Spec Unit
receivesEventImg event fire =
  renderAndCheck
    event
    (mkEventImg event syntheticEvent)
    (read <<< unsafeToForeign)
    \{ findByAltText } ->
      findByAltText "event-component" >>= fire

receivesEventInput
  ∷ ∀ a props props_ elem
   . IsSymbol elem
  => Show a
  => Eq a
  => Cons elem EventHandler (children ∷ Array JSX) props
  => Lacks elem (children ∷ Array JSX)
  => Union props props_ Props_div
  => ReadForeign a
  => Proxy elem
  -> (HTMLElement -> Aff Unit)
  -> a
  -> Spec Unit
receivesEventInput event fire =
  renderAndCheck
    event
    (mkEventInput event syntheticEvent)
    (read <<< unsafeToForeign)
    \{ findByLabelText } ->
      findByLabelText "Input Label" >>= fire

receivesEventData
  ∷ ∀ t25 t26 t39 t49
   . IsSymbol t26
  => Cons t26 EventHandler (_data ∷ Object String, style ∷ CSS) t25
  => Lacks
       t26
       ( _data ∷ Object String
       , style ∷ CSS
       )
  => Discard t39
  => Show t49
  => Eq t49
  => (Record t25 -> JSX)
  -> EventFn SyntheticEvent t49
  -> Proxy t26
  -> (HTMLElement -> Aff t39)
  -> t49
  -> Spec Unit
receivesEventData elem fn event fire expected =
  it (reflectSymbol event) do
    var <- AVar.empty
    comp <-
      liftEffect
        $ mkEventElem elem event fn
        $ \x -> var # AVar.put x
    { findByTestId } <- renderComponent comp {}
    findByTestId "event-component" >>= fire
    actual <- AVar.tryRead var
    actual `shouldEqual` Just expected

printErrors ∷ MultipleErrors -> String
printErrors errs = errs # intercalateMap ",\n\t" renderForeignError
  where
  renderForeignError ∷ ForeignError -> String
  renderForeignError = case _ of
    ForeignError msg -> msg
    ErrorAtIndex i e -> "[" <> show i <> "]: " <> renderForeignError e
    ErrorAtProperty prop e -> show prop <> " " <> renderForeignError e
    TypeMismatch exp "Undefined" -> "missing (should be of type " <> exp <> ")"
    TypeMismatch exp act -> "property has wrong type " <> exp <> " ≠ " <> act
