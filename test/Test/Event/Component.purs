module Test.Event.Component where

import Prelude

import Data.Symbol (class IsSymbol)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Uncurried (EffectFn1)
import Foreign.Object (Object)
import Foreign.Object as Obj
import Prim.Row (class Cons, class Lacks, class Union)
import React.Basic.DOM (CSS, Props_div, Props_img, css)
import React.Basic.DOM as R
import React.Basic.Events (EventFn, SyntheticEvent, handler)
import React.Basic.Hooks (JSX, ReactComponent, reactComponent)
import Record.Builder as RB
import Type.Prelude (Proxy(..))

mkEventElem
  ∷ ∀ eventFn on r props
   . Cons on (EffectFn1 SyntheticEvent Unit) (_data ∷ Object String, style ∷ CSS) r
  => Lacks on (_data ∷ Object String, style ∷ CSS)
  => IsSymbol on
  => Lacks "key" props
  => Lacks "ref" props
  => Lacks "children" props
  => (Record r -> JSX)
  -> Proxy on
  -> EventFn SyntheticEvent eventFn
  -> (eventFn -> Aff Unit)
  -> Effect (ReactComponent (Record props))
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

mkEventImg
  ∷ ∀ t123 t128 t129 t135 t139 t140
   . Cons
       t123
       (EffectFn1 SyntheticEvent Unit)
       ( alt ∷ String
       , tabIndex ∷ Int
       )
       t140
  => Lacks
       t123
       ( alt ∷ String
       , tabIndex ∷ Int
       )
  => IsSymbol t123
  => Lacks "children" t135
  => Lacks "key" t135
  => Lacks "ref" t135
  => Union t140 t139 Props_img
  => Proxy t123
  -> EventFn SyntheticEvent t128
  -> (t128 -> Aff t129)
  -> Effect (ReactComponent (Record t135))
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
      ( handler eventFn (launchAff_ <<< void <<< theHandler)
      )

mkEventInput
  ∷ ∀ t108 t112 t113 t88 t93 t94
   . Cons t88 (EffectFn1 SyntheticEvent Unit) (children ∷ Array JSX) t113
  => Lacks t88 (children ∷ Array JSX)
  => IsSymbol t88
  => Lacks "children" t108
  => Lacks "key" t108
  => Lacks "ref" t108
  => Union t113 t112 Props_div
  => Proxy t88
  -> EventFn SyntheticEvent t93
  -> (t93 -> Aff t94)
  -> Effect (ReactComponent (Record t108))
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
      ( handler eventFn (launchAff_ <<< void <<< theHandler)
      )

on
  ∷ { abort ∷ Proxy "onAbort"
    , animationEnd ∷ Proxy "onAnimationEnd"
    , animationIteration ∷ Proxy "onAnimationIteration"
    , animationStart ∷ Proxy "onAnimationStart"
    , blur ∷ Proxy "onBlur"
    , canPlay ∷ Proxy "onCanPlay"
    , canPlayThrough ∷ Proxy "onCanPlayThrough"
    , change ∷ Proxy "onChange"
    , click ∷ Proxy "onClick"
    , compositionEnd ∷ Proxy "onCompositionEnd"
    , compositionStart ∷ Proxy "onCompositionStart"
    , compositionUpdate ∷ Proxy "onCompositionUpdate"
    , contextMenu ∷ Proxy "onContextMenu"
    , copy ∷ Proxy "onCopy"
    , cut ∷ Proxy "onCut"
    , doubleClick ∷ Proxy "onDblClick"
    , drag ∷ Proxy "onDrag"
    , dragEnd ∷ Proxy "onDragEnd"
    , dragEnter ∷ Proxy "onDragEnter"
    , dragExit ∷ Proxy "onDragExit"
    , dragLeave ∷ Proxy "onDragLeave"
    , dragOver ∷ Proxy "onDragOver"
    , dragStart ∷ Proxy "onDragStart"
    , drop ∷ Proxy "onDrop"
    , durationChange ∷ Proxy "onDurationChange"
    , emptied ∷ Proxy "onEmptied"
    , encrypted ∷ Proxy "onEncrypted"
    , ended ∷ Proxy "onEnded"
    , error ∷ Proxy "onError"
    , focus ∷ Proxy "onFocus"
    , focusIn ∷ Proxy "onFocusIn"
    , focusOut ∷ Proxy "onFocusOut"
    , gotPointerCapture ∷ Proxy "onGotPointerCapture"
    , input ∷ Proxy "onInput"
    , invalid ∷ Proxy "onInvalid"
    , keyDown ∷ Proxy "onKeyDown"
    , keyPress ∷ Proxy "onKeyPress"
    , keyUp ∷ Proxy "onKeyUp"
    , load ∷ Proxy "onLoad"
    , loadStart ∷ Proxy "onLoadStart"
    , loadedData ∷ Proxy "onLoadedData"
    , loadedMetadata ∷ Proxy "onLoadedMetadata"
    , lostPointerCapture ∷ Proxy "onLostPointerCapture"
    , mouseDown ∷ Proxy "onMouseDown"
    , mouseEnter ∷ Proxy "onMouseEnter"
    , mouseLeave ∷ Proxy "onMouseLeave"
    , mouseMove ∷ Proxy "onMouseMove"
    , mouseOut ∷ Proxy "onMouseOut"
    , mouseOver ∷ Proxy "onMouseOver"
    , mouseUp ∷ Proxy "onMouseUp"
    , paste ∷ Proxy "onPaste"
    , pause ∷ Proxy "onPause"
    , play ∷ Proxy "onPlay"
    , playing ∷ Proxy "onPlaying"
    , pointerCancel ∷ Proxy "onPointerCancel"
    , pointerDown ∷ Proxy "onPointerDown"
    , pointerEnter ∷ Proxy "onPointerEnter"
    , pointerLeave ∷ Proxy "onPointerLeave"
    , pointerMove ∷ Proxy "onPointerMove"
    , pointerOut ∷ Proxy "onPointerOut"
    , pointerOver ∷ Proxy "onPointerOver"
    , pointerUp ∷ Proxy "onPointerUp"
    , progress ∷ Proxy "onProgress"
    , rateChange ∷ Proxy "onRateChange"
    , scroll ∷ Proxy "onScroll"
    , seeked ∷ Proxy "onSeeked"
    , seeking ∷ Proxy "onSeeking"
    , select ∷ Proxy "onSelect"
    , stalled ∷ Proxy "onStalled"
    , submit ∷ Proxy "onSubmit"
    , suspend ∷ Proxy "onSuspend"
    , timeUpdate ∷ Proxy "onTimeUpdate"
    , touchCancel ∷ Proxy "onTouchCancel"
    , touchEnd ∷ Proxy "onTouchEnd"
    , touchMove ∷ Proxy "onTouchMove"
    , touchStart ∷ Proxy "onTouchStart"
    , transitionEnd ∷ Proxy "onTransitionEnd"
    , volumeChange ∷ Proxy "onVolumeChange"
    , waiting ∷ Proxy "onWaiting"
    , wheel ∷ Proxy "onWheel"
    }
on =
  { copy: Proxy ∷ Proxy "onCopy"
  , cut: Proxy ∷ Proxy "onCut"
  , paste: Proxy ∷ Proxy "onPaste"
  , compositionEnd: Proxy ∷ Proxy "onCompositionEnd"
  , compositionStart: Proxy ∷ Proxy "onCompositionStart"
  , compositionUpdate: Proxy ∷ Proxy "onCompositionUpdate"
  , keyDown: Proxy ∷ Proxy "onKeyDown"
  , keyPress: Proxy ∷ Proxy "onKeyPress"
  , keyUp: Proxy ∷ Proxy "onKeyUp"
  , focus: Proxy ∷ Proxy "onFocus"
  , blur: Proxy ∷ Proxy "onBlur"
  , focusIn: Proxy ∷ Proxy "onFocusIn"
  , focusOut: Proxy ∷ Proxy "onFocusOut"
  , change: Proxy ∷ Proxy "onChange"
  , input: Proxy ∷ Proxy "onInput"
  , invalid: Proxy ∷ Proxy "onInvalid"
  , submit: Proxy ∷ Proxy "onSubmit"
  , click: Proxy ∷ Proxy "onClick"
  , contextMenu: Proxy ∷ Proxy "onContextMenu"
  , drag: Proxy ∷ Proxy "onDrag"
  , dragEnd: Proxy ∷ Proxy "onDragEnd"
  , dragEnter: Proxy ∷ Proxy "onDragEnter"
  , dragExit: Proxy ∷ Proxy "onDragExit"
  , dragLeave: Proxy ∷ Proxy "onDragLeave"
  , dragOver: Proxy ∷ Proxy "onDragOver"
  , dragStart: Proxy ∷ Proxy "onDragStart"
  , drop: Proxy ∷ Proxy "onDrop"
  , mouseDown: Proxy ∷ Proxy "onMouseDown"
  , mouseEnter: Proxy ∷ Proxy "onMouseEnter"
  , mouseLeave: Proxy ∷ Proxy "onMouseLeave"
  , mouseMove: Proxy ∷ Proxy "onMouseMove"
  , mouseOut: Proxy ∷ Proxy "onMouseOut"
  , mouseOver: Proxy ∷ Proxy "onMouseOver"
  , mouseUp: Proxy ∷ Proxy "onMouseUp"
  , select: Proxy ∷ Proxy "onSelect"
  , touchCancel: Proxy ∷ Proxy "onTouchCancel"
  , touchEnd: Proxy ∷ Proxy "onTouchEnd"
  , touchMove: Proxy ∷ Proxy "onTouchMove"
  , touchStart: Proxy ∷ Proxy "onTouchStart"
  , scroll: Proxy ∷ Proxy "onScroll"
  , wheel: Proxy ∷ Proxy "onWheel"
  , abort: Proxy ∷ Proxy "onAbort"
  , canPlay: Proxy ∷ Proxy "onCanPlay"
  , canPlayThrough: Proxy ∷ Proxy "onCanPlayThrough"
  , durationChange: Proxy ∷ Proxy "onDurationChange"
  , emptied: Proxy ∷ Proxy "onEmptied"
  , encrypted: Proxy ∷ Proxy "onEncrypted"
  , ended: Proxy ∷ Proxy "onEnded"
  , loadedData: Proxy ∷ Proxy "onLoadedData"
  , loadedMetadata: Proxy ∷ Proxy "onLoadedMetadata"
  , loadStart: Proxy ∷ Proxy "onLoadStart"
  , pause: Proxy ∷ Proxy "onPause"
  , play: Proxy ∷ Proxy "onPlay"
  , playing: Proxy ∷ Proxy "onPlaying"
  , progress: Proxy ∷ Proxy "onProgress"
  , rateChange: Proxy ∷ Proxy "onRateChange"
  , seeked: Proxy ∷ Proxy "onSeeked"
  , seeking: Proxy ∷ Proxy "onSeeking"
  , stalled: Proxy ∷ Proxy "onStalled"
  , suspend: Proxy ∷ Proxy "onSuspend"
  , timeUpdate: Proxy ∷ Proxy "onTimeUpdate"
  , volumeChange: Proxy ∷ Proxy "onVolumeChange"
  , waiting: Proxy ∷ Proxy "onWaiting"
  , load: Proxy ∷ Proxy "onLoad"
  , error: Proxy ∷ Proxy "onError"
  , animationStart: Proxy ∷ Proxy "onAnimationStart"
  , animationEnd: Proxy ∷ Proxy "onAnimationEnd"
  , animationIteration: Proxy ∷ Proxy "onAnimationIteration"
  , transitionEnd: Proxy ∷ Proxy "onTransitionEnd"
  , doubleClick: Proxy ∷ Proxy "onDblClick"
  , pointerOver: Proxy ∷ Proxy "onPointerOver"
  , pointerEnter: Proxy ∷ Proxy "onPointerEnter"
  , pointerDown: Proxy ∷ Proxy "onPointerDown"
  , pointerMove: Proxy ∷ Proxy "onPointerMove"
  , pointerUp: Proxy ∷ Proxy "onPointerUp"
  , pointerCancel: Proxy ∷ Proxy "onPointerCancel"
  , pointerOut: Proxy ∷ Proxy "onPointerOut"
  , pointerLeave: Proxy ∷ Proxy "onPointerLeave"
  , gotPointerCapture: Proxy ∷ Proxy "onGotPointerCapture"
  , lostPointerCapture: Proxy ∷ Proxy "onLostPointerCapture"
  }
