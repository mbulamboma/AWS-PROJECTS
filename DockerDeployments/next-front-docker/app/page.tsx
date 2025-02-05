// app/page.tsx
'use client';

import React, { useEffect, useState } from 'react';

const Home: React.FC = () => {
  const [hostname, setHostname] = useState<string>('');

  useEffect(() => {
    if (typeof window !== 'undefined') {
      setHostname(window.location.hostname);
    }
  }, []);

  const handleClick = () => {
    alert('Button clicked!');
  };

  return (
    <main style={mainStyle}>
      <div style={containerStyle}>
        <p>Hostname: {hostname}</p>
        <button style={buttonStyle} onClick={handleClick}>
          Click Me
        </button>
      </div>
    </main>
  );
};

const mainStyle: React.CSSProperties = {
  display: 'flex',
  justifyContent: 'center',
  alignItems: 'center',
  height: '80vh',
};

const containerStyle: React.CSSProperties = {
  textAlign: 'center',
};

const buttonStyle: React.CSSProperties = {
  padding: '10px 20px',
  fontSize: '16px',
  cursor: 'pointer',
  marginTop: '20px',
};

export default Home;
