import React, { useState } from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';

function App() {
  const [response, setResponse] = useState<string>('');

  const fetchBackendData = async () => {
    try {
      const res = await axios.get(process.env.REACT_APP_PHP_BACKEND_API + '/api/hello');
      setResponse(res.data.message);
    } catch (error) {
      setResponse('Error fetching data');
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <button onClick={fetchBackendData} className="App-button">
          Fetch API Data
        </button>
        <p>{response}</p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
