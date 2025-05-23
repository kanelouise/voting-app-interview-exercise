import React, { useEffect, useState } from 'react';

function ResultsDashboard() {
  console.log("Rendering ResultsDashboard"); // <- add this line

  const [results, setResults] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    fetch('/results', {
      credentials: 'include', // Include cookies (optional)
    })
      .then((res) => {
        if (!res.ok) throw new Error("Network error");
        return res.json();
      })
      .then((data) => setResults(data))
      .catch(() => setError('Failed to load results'));
  }, []);

  return (
  //   <div>
  //     <h2>Results Dashboard</h2>
  //     {error && <p className="text-red-600">{error}</p>}
  //     <ul>
  //       {results.map(c => (
  //         <li key={c.id} className="mb-2">
  //           <span className="font-medium">{c.name}</span>: {c.votes} votes
  //         </li>
  //       ))}
  //     </ul>
  //   </div>
  // );
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
