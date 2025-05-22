// app/javascript/components/Vote.jsx
import React, { useEffect, useState } from 'react';

function Vote({ voterId }) {
  const [candidates, setCandidates] = useState([]);
  const [selectedCandidateId, setSelectedCandidateId] = useState(null);
  const [writeIn, setWriteIn] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  useEffect(() => {
    fetch('/candidates')
      .then(res => res.json())
      .then(setCandidates)
      .catch(() => setError('Failed to load candidates'));
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setMessage('');

    const token = document.querySelector('meta[name="csrf-token"]')?.content;

    const payload = writeIn
      ? { write_in_candidate: writeIn }
      : { candidate_id: selectedCandidateId };

    const response = await fetch('/votes', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token,
      },
      credentials: 'include',
      body: JSON.stringify(payload),
    });

    const data = await response.json();
    if (response.ok) {
      setMessage(data.message);
    } else {
      setError(data.error || 'Something went wrong');
    }
  };

  return (
    <div>
      <h2>Cast Your Vote</h2>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {message && <p style={{ color: 'green' }}>{message}</p>}

      <form onSubmit={handleSubmit}>
        <div>
          <label>Select a candidate:</label>
          {candidates.map(c => (
            <div key={c.id}>
              <input
                type="radio"
                name="candidate"
                value={c.id}
                checked={selectedCandidateId === c.id}
                onChange={() => {
                  setSelectedCandidateId(c.id);
                  setWriteIn('');
                }}
              />
              {c.name}
            </div>
          ))}
        </div>

        <div>
          <label>Or write in a new candidate:</label>
          <input
            type="text"
            value={writeIn}
            onChange={(e) => {
              setWriteIn(e.target.value);
              setSelectedCandidateId(null);
            }}
          />
        </div>

        <button type="submit">Submit Vote</button>
      </form>
    </div>
  );
}

export default Vote;

