import React, { useState } from 'react';

function Login({ onLoginSuccess }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [zipCode, setZipCode] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    const response = await fetch('/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password, zip_code: zipCode }),
    });

    const data = await response.json();

    if (response.ok) {
      onLoginSuccess?.(data.voter_id);
    } else {
      setError(data.error || 'Login failed');
    }
  };

  return (
    <div>
      <h2>Log In</h2>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      <form onSubmit={handleSubmit}>
        <div>
          <label>Email:</label><br />
          <input value={email} onChange={(e) => setEmail(e.target.value)} required />
        </div>
        <div>
          <label>Password:</label><br />
          <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
        </div>
        <div>
          <label>Zip Code:</label><br />
          <input value={zipCode} onChange={(e) => setZipCode(e.target.value)} required />
        </div>
        <button type="submit">Log In</button>
      </form>
    </div>
  );
}

export default Login;
