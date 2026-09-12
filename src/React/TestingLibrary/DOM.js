import { waitFor as testingWaitFor } from "@testing-library/react";

export const stubGeometry = element => measure => () => {
  const names = ["getBoundingClientRect", "clientWidth", "clientHeight"];
  const descriptors = names.map(name => Object.getOwnPropertyDescriptor(element, name));
  Object.defineProperties(element, {
    getBoundingClientRect: { configurable: true, value: () => {
      const { x, y, width, height } = measure();
      return new DOMRect(x, y, width, height);
    } },
    clientWidth: { configurable: true, get: () => measure().width },
    clientHeight: { configurable: true, get: () => measure().height },
  });
  return () => names.forEach((name, index) => {
    if (descriptors[index]) Object.defineProperty(element, name, descriptors[index]);
    else delete element[name];
  });
};

export const captureConsole = method => () => {
  const captured = [];
  const original = console[method];
  console[method] = (...args) => { captured.push(args.map(String).join(" ")); };
  return () => { console[method] = original; return captured; };
};

export const waitFor = assertion => timeout => () => testingWaitFor(assertion, { timeout });

export const dispatchEvent = type => target => () => { target.dispatchEvent(new Event(type)); };
