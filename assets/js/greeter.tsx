import React from 'react';

function Greeter() {
  const [count, setCount] = React.useState(0);

  return (
    <div className="my-2 p-4 bg-yellow-100 rounded-lg space-y-3 space-x-2">
      <h1>Welcome!</h1>
      <h3>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel
        lacinia leo. Proin nec ullamcorper risus. Nulla scelerisque porttitor
        ornare. Fusce bibendum elementum dolor, vel lobortis nibh ullamcorper
        ut.
      </h3>
      <h4>Count: {count}</h4>
      <button
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        onClick={() => setCount(count + 1)}
      >
        Increment
      </button>
      <button
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        onClick={() => setCount(count - 1)}
      >
        Decrement
      </button>
    </div>
  );
}

export default Greeter;
