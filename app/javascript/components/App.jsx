// app/javascript/components/App.jsx
import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './Login';
import Vote from './Vote';
import ResultsDashboard from './ResultsDashboard';
import NotFound from './NotFound';

function App() {
  const [voterId, setVoterId] = useState(null);

  return (
    <Router>
      <Routes>
        {/* If not logged in, show Login page. If logged in, redirect to /vote */}
        <Route
          path="/"
          element={
            voterId ? (
              <Navigate to="/vote" />
            ) : (
              <Login onLoginSuccess={setVoterId} />
            )
          }
        />

        {/* Protected Vote page: if not logged in, redirect to / */}
        <Route
          path="/vote"
          element={
            voterId ? (
              <Vote voterId={voterId} />
            ) : (
              <Navigate to="/" />
            )
          }
        />

        {/* Unprotected Results page */}
        <Route path="/results" element={<ResultsDashboard />} />

        {/* Unprotected Not Found page */}
        <Route path="/*" element={<NotFound/>} />
      </Routes>
    </Router>
  );
}

export default App;

