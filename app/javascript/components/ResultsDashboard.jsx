import React, { useEffect, useState } from 'react';

function ResultsDashboard() {
  
  const [results, setResults] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    fetch('/api/results', {
      credentials: 'include',
    })
      .then((res) => {
        if (!res.ok) throw new Error("Network error");
        return res.json();
      })
      .then((data) => setResults(data))
      .catch(() => setError('Failed to load results'));
  }, []);

  return (
    <div>
      <h2>Results Dashboard</h2>
      {error && <p style={{ color: 'red' }}>{error}</p>}

      <table border="1" cellPadding="8" cellSpacing="0">
        <thead>
          <tr>
            <th>Candidate</th>
            <th>Votes</th>
          </tr>
        </thead>
        <tbody>
          {results.map((c) => (
            <tr key={c.id}>
              <td>{c.name}</td>
              <td>{c.votes}</td>
            </tr>
          ))}
        </tbody>
      </table>
  </div>
  );
}

export default ResultsDashboard;
