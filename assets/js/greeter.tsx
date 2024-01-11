import React from 'react';

function Greeter({ onClick }: { onClick: (increment: number) => void }) {
  return (
    <div className="my-2 p-4 bg-yellow-100 rounded-lg space-y-3 space-x-2">
      <h1>This is a React component</h1>
      <button
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        onClick={() => onClick(1)}
      >
        +1
      </button>
      <button
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        onClick={() => onClick(-1)}
      >
        -1
      </button>
    </div>
  );
}

export default Greeter;
