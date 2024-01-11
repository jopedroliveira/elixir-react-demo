import React from 'react';
import ReactDOM from 'react-dom/client';
import Greeter from './greeter';

const GreeterHook = {
  mounted() {
    const hook = this;

    const greeting = this.el as Element;
    const root = ReactDOM.createRoot(greeting);
    root.render(<Greeter />);
  },
} as any;

export default GreeterHook;
