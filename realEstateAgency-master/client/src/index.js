import React from "react";
import ReactDOM from "react-dom";
import App from "./App";
import { BrowserRouter as Router } from "react-router-dom";
import GlobalContextProvider from "./context/GlobalContext";

ReactDOM.render(
  <React.StrictMode>
    <Router>
      <GlobalContextProvider>
        <App />
      </GlobalContextProvider>
    </Router>
  </React.StrictMode>,
  document.getElementById("root")
);
