module Test.Event.Component where

import Prelude
import Data.Symbol (class IsSymbol, SProxy(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Uncurried (EffectFn1)
import Foreign.Object (Object)
import Foreign.Object as Obj
import Prim.Row (class Cons, class Lacks)
import React.Basic.DOM (CSS, css)
import React.Basic.DOM as R
import React.Basic.Events (EventFn, SyntheticEvent, handler)
import React.Basic.Hooks (JSX, ReactComponent, reactComponent)
import Record.Builder as RB

mkEventElem ∷
  ∀ eventFn on r props.
  Cons on (EffectFn1 SyntheticEvent Unit) ( _data ∷ Object String, style ∷ CSS ) r =>
  Lacks on ( _data ∷ Object String, style ∷ CSS ) =>
  IsSymbol on =>
  Lacks "key" props =>
  Lacks "ref" props =>
  Lacks "children" props =>
  (Record r -> JSX) ->
  SProxy on ->
  EventFn SyntheticEvent eventFn ->
  (eventFn -> Aff Unit) ->
  Effect (ReactComponent (Record props))
mkEventElem elem onWhat eventFn theHandler =
  reactComponent "EventComponent" \_ -> React.do
    pure (elem built)
  where
  built =
    RB.build attrs
      { _data: Obj.singleton "testid" "event-component"
      , style: css { width: "10px", height: "10px" }
      }

  attrs =
    RB.insert onWhat
      ( handler eventFn (launchAff_ <<< theHandler)
      )

mkEventImg onWhat eventFn theHandler =
  reactComponent "EventComponent" \_ -> React.do
    pure (R.img built)
  where
  built =
    RB.build attrs
      { alt: "event-component"
      , tabIndex: 0 -- for key events
      }

  attrs =
    RB.insert onWhat
      ( handler eventFn (launchAff_ <<< theHandler)
      )

mkEventInput onWhat eventFn theHandler =
  reactComponent "EventComponent" \_ -> React.do
    pure (R.div built)
  where
  built =
    RB.build attrs
      { children:
        [ R.input { id: "input-id" }
        , R.label { htmlFor: "input-id", children: [ R.text "Input Label" ] }
        ]
      }

  attrs =
    RB.insert onWhat
      ( handler eventFn (launchAff_ <<< theHandler)
      )

on =
  { copy: SProxy ∷ SProxy "onCopy"
  , cut: SProxy ∷ SProxy "onCut"
  , paste: SProxy ∷ SProxy "onPaste"
  , compositionEnd: SProxy ∷ SProxy "onCompositionEnd"
  , compositionStart: SProxy ∷ SProxy "onCompositionStart"
  , compositionUpdate: SProxy ∷ SProxy "onCompositionUpdate"
  , keyDown: SProxy ∷ SProxy "onKeyDown"
  , keyPress: SProxy ∷ SProxy "onKeyPress"
  , keyUp: SProxy ∷ SProxy "onKeyUp"
  , focus: SProxy ∷ SProxy "onFocus"
  , blur: SProxy ∷ SProxy "onBlur"
  , focusIn: SProxy ∷ SProxy "onFocusIn"
  , focusOut: SProxy ∷ SProxy "onFocusOut"
  , change: SProxy ∷ SProxy "onChange"
  , input: SProxy ∷ SProxy "onInput"
  , invalid: SProxy ∷ SProxy "onInvalid"
  , submit: SProxy ∷ SProxy "onSubmit"
  , click: SProxy ∷ SProxy "onClick"
  , contextMenu: SProxy ∷ SProxy "onContextMenu"
  , drag: SProxy ∷ SProxy "onDrag"
  , dragEnd: SProxy ∷ SProxy "onDragEnd"
  , dragEnter: SProxy ∷ SProxy "onDragEnter"
  , dragExit: SProxy ∷ SProxy "onDragExit"
  , dragLeave: SProxy ∷ SProxy "onDragLeave"
  , dragOver: SProxy ∷ SProxy "onDragOver"
  , dragStart: SProxy ∷ SProxy "onDragStart"
  , drop: SProxy ∷ SProxy "onDrop"
  , mouseDown: SProxy ∷ SProxy "onMouseDown"
  , mouseEnter: SProxy ∷ SProxy "onMouseEnter"
  , mouseLeave: SProxy ∷ SProxy "onMouseLeave"
  , mouseMove: SProxy ∷ SProxy "onMouseMove"
  , mouseOut: SProxy ∷ SProxy "onMouseOut"
  , mouseOver: SProxy ∷ SProxy "onMouseOver"
  , mouseUp: SProxy ∷ SProxy "onMouseUp"
  , select: SProxy ∷ SProxy "onSelect"
  , touchCancel: SProxy ∷ SProxy "onTouchCancel"
  , touchEnd: SProxy ∷ SProxy "onTouchEnd"
  , touchMove: SProxy ∷ SProxy "onTouchMove"
  , touchStart: SProxy ∷ SProxy "onTouchStart"
  , scroll: SProxy ∷ SProxy "onScroll"
  , wheel: SProxy ∷ SProxy "onWheel"
  , abort: SProxy ∷ SProxy "onAbort"
  , canPlay: SProxy ∷ SProxy "onCanPlay"
  , canPlayThrough: SProxy ∷ SProxy "onCanPlayThrough"
  , durationChange: SProxy ∷ SProxy "onDurationChange"
  , emptied: SProxy ∷ SProxy "onEmptied"
  , encrypted: SProxy ∷ SProxy "onEncrypted"
  , ended: SProxy ∷ SProxy "onEnded"
  , loadedData: SProxy ∷ SProxy "onLoadedData"
  , loadedMetadata: SProxy ∷ SProxy "onLoadedMetadata"
  , loadStart: SProxy ∷ SProxy "onLoadStart"
  , pause: SProxy ∷ SProxy "onPause"
  , play: SProxy ∷ SProxy "onPlay"
  , playing: SProxy ∷ SProxy "onPlaying"
  , progress: SProxy ∷ SProxy "onProgress"
  , rateChange: SProxy ∷ SProxy "onRateChange"
  , seeked: SProxy ∷ SProxy "onSeeked"
  , seeking: SProxy ∷ SProxy "onSeeking"
  , stalled: SProxy ∷ SProxy "onStalled"
  , suspend: SProxy ∷ SProxy "onSuspend"
  , timeUpdate: SProxy ∷ SProxy "onTimeUpdate"
  , volumeChange: SProxy ∷ SProxy "onVolumeChange"
  , waiting: SProxy ∷ SProxy "onWaiting"
  , load: SProxy ∷ SProxy "onLoad"
  , error: SProxy ∷ SProxy "onError"
  , animationStart: SProxy ∷ SProxy "onAnimationStart"
  , animationEnd: SProxy ∷ SProxy "onAnimationEnd"
  , animationIteration: SProxy ∷ SProxy "onAnimationIteration"
  , transitionEnd: SProxy ∷ SProxy "onTransitionEnd"
  , doubleClick: SProxy ∷ SProxy "onDblClick"
  , pointerOver: SProxy ∷ SProxy "onPointerOver"
  , pointerEnter: SProxy ∷ SProxy "onPointerEnter"
  , pointerDown: SProxy ∷ SProxy "onPointerDown"
  , pointerMove: SProxy ∷ SProxy "onPointerMove"
  , pointerUp: SProxy ∷ SProxy "onPointerUp"
  , pointerCancel: SProxy ∷ SProxy "onPointerCancel"
  , pointerOut: SProxy ∷ SProxy "onPointerOut"
  , pointerLeave: SProxy ∷ SProxy "onPointerLeave"
  , gotPointerCapture: SProxy ∷ SProxy "onGotPointerCapture"
  , lostPointerCapture: SProxy ∷ SProxy "onLostPointerCapture"
  }
