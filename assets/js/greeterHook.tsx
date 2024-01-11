import React from 'react';
import ReactDOM from 'react-dom/client';
import Greeter from './greeter';

const GreeterHook = {
  mounted() {
    const hook = this;
    const element = this.el as Element;

    const onClick = (increment: number) => {
      hook.pushEventTo(`#${element.id}`, 'increment', { increment });
    };

    const root = ReactDOM.createRoot(element);
    root.render(<Greeter onClick={onClick} />);
  },
} as any;

export default GreeterHook;
