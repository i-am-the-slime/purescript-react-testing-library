// So that we have a "document"
import "global-jsdom/register"

// We're not using jest or any other compatible framework
import "@testing-library/react/dont-cleanup-after-each.js"
import {
  configure,
  cleanup,
  render,
  findByText,
  fireEvent
} from "@testing-library/react/pure.js"
import UE from "@testing-library/user-event"

configure({ defaultHidden: true })
export const cleanupImpl = () => cleanup()

export const renderImpl = render

export const findByTextImpl = (HTMLElement, String) => () =>
  findByText(HTMLElement, String)

export function queryImpl(just) {
  return (nothing) => (query) => (elem) => {
    let result = query(elem)
    return result === null ? nothing : just(result)
  }
}

export const fireEventImpl = fireEvent
export const fireEventCopyImpl = fireEvent.copy
export const fireEventCutImpl = fireEvent.cut
export const fireEventPasteImpl = fireEvent.paste
export const fireEventCompositionEndImpl = fireEvent.compositionEnd
export const fireEventCompositionStartImpl = fireEvent.compositionStart
export const fireEventCompositionUpdateImpl = fireEvent.compositionUpdate
export const fireEventKeyDownImpl = fireEvent.keyDown
export const fireEventKeyUpImpl = fireEvent.keyUp
export const fireEventKeyPressImpl = fireEvent.keyPress
export const fireEventFocusImpl = fireEvent.focus
export const fireEventBlurImpl = fireEvent.blur
export const fireEventFocusInImpl = fireEvent.focusIn
export const fireEventFocusOutImpl = fireEvent.focusOut
export const fireEventChangeImpl = fireEvent.change
export const fireEventInputImpl = fireEvent.input
export const fireEventInvalidImpl = fireEvent.invalid
export const fireEventSubmitImpl = fireEvent.submit
export const fireEventClickImpl = fireEvent.click
export const fireEventContextMenuImpl = fireEvent.contextMenu
export const fireEventDblClickImpl = fireEvent.dblClick
export const fireEventDragImpl = fireEvent.drag
export const fireEventDragEndImpl = fireEvent.dragEnd
export const fireEventDragEnterImpl = fireEvent.dragEnter
export const fireEventDragExitImpl = fireEvent.dragExit
export const fireEventDragLeaveImpl = fireEvent.dragLeave
export const fireEventDragOverImpl = fireEvent.dragOver
export const fireEventDragStartImpl = fireEvent.dragStart
export const fireEventDropImpl = fireEvent.drop
export const fireEventMouseDownImpl = fireEvent.mouseDown
export const fireEventMouseEnterImpl = fireEvent.mouseEnter
export const fireEventMouseLeaveImpl = fireEvent.mouseLeave
export const fireEventMouseMoveImpl = fireEvent.mouseMove
export const fireEventMouseOutImpl = fireEvent.mouseOut
export const fireEventMouseOverImpl = fireEvent.mouseOver
export const fireEventMouseUpImpl = fireEvent.mouseUp
export const fireEventSelectImpl = fireEvent.select
export const fireEventTouchCancelImpl = fireEvent.touchCancel
export const fireEventTouchEndImpl = fireEvent.touchEnd
export const fireEventTouchMoveImpl = fireEvent.touchMove
export const fireEventTouchStartImpl = fireEvent.touchStart
export const fireEventScrollImpl = fireEvent.scroll
export const fireEventWheelImpl = fireEvent.wheel
export const fireEventAbortImpl = fireEvent.abort
export const fireEventCanPlayImpl = fireEvent.canPlay
export const fireEventCanPlayThroughImpl = fireEvent.canPlayThrough
export const fireEventDurationChangeImpl = fireEvent.durationChange
export const fireEventEmptiedImpl = fireEvent.emptied
export const fireEventEncryptedImpl = fireEvent.encrypted
export const fireEventEndedImpl = fireEvent.ended
export const fireEventLoadedDataImpl = fireEvent.loadedData
export const fireEventLoadedMetadataImpl = fireEvent.loadedMetadata
export const fireEventLoadStartImpl = fireEvent.loadStart
export const fireEventPauseImpl = fireEvent.pause
export const fireEventPlayImpl = fireEvent.play
export const fireEventPlayingImpl = fireEvent.playing
export const fireEventProgressImpl = fireEvent.progress
export const fireEventRateChangeImpl = fireEvent.rateChange
export const fireEventSeekedImpl = fireEvent.seeked
export const fireEventSeekingImpl = fireEvent.seeking
export const fireEventStalledImpl = fireEvent.stalled
export const fireEventSuspendImpl = fireEvent.suspend
export const fireEventTimeUpdateImpl = fireEvent.timeUpdate
export const fireEventVolumeChangeImpl = fireEvent.volumeChange
export const fireEventWaitingImpl = fireEvent.waiting
export const fireEventLoadImpl = fireEvent.load
export const fireEventErrorImpl = fireEvent.error
export const fireEventAnimationStartImpl = fireEvent.animationStart
export const fireEventAnimationEndImpl = fireEvent.animationEnd
export const fireEventAnimationIterationImpl = fireEvent.animationIteration
export const fireEventTransitionEndImpl = fireEvent.transitionEnd
export const fireEventDoubleClickImpl = fireEvent.doubleClick
export const fireEventPointerOverImpl = fireEvent.pointerOver
export const fireEventPointerEnterImpl = fireEvent.pointerEnter
export const fireEventPointerDownImpl = fireEvent.pointerDown
export const fireEventPointerMoveImpl = fireEvent.pointerMove
export const fireEventPointerUpImpl = fireEvent.pointerUp
export const fireEventPointerCancelImpl = fireEvent.pointerCancel
export const fireEventPointerOutImpl = fireEvent.pointerOut
export const fireEventPointerLeaveImpl = fireEvent.pointerLeave
export const fireEventGotPointerCaptureImpl = fireEvent.gotPointerCapture
export const fireEventLostPointerCaptureImpl = fireEvent.lostPointerCapture

export const typeImpl = (HTMLElement, String, Foreign) => () =>
  UE.type(HTMLElement, String, Foreign)
