import React from "react";
import ReactDOM from "react-dom/client";
import App from "../components/App"; // or wherever your main component is
import "./application.css";
import ReactRailsUJS from 'react_ujs';
ReactRailsUJS.useContext(require.context('components', true));

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
