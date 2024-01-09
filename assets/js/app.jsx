import 'phoenix_html';
import { Socket } from 'phoenix';
import React from 'react';
import ReactDOM from 'react-dom/client';
import { LiveSocket } from 'phoenix_live_view';

import Greeter from './greeter';

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content');

let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
});

const greeting = document.getElementById('greetings');
const root = ReactDOM.createRoot(greeting);
root.render(<Greeter name={greeting.dataset.name} />);

liveSocket.connect();
window.liveSocket = liveSocket;
