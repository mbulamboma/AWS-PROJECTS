// app/components/Header.tsx
import React from 'react';

const Header: React.FC = () => {
  return (
    <header style={headerStyle}>
      <h1>Frontend Applicatoin</h1>
    </header>
  );
};

const headerStyle: React.CSSProperties = {
  backgroundColor: '#333',
  color: '#fff',
  padding: '10px',
  textAlign: 'center',
};

export default Header;
