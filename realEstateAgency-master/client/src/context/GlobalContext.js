import { createContext, useReducer } from "react";
import { mainReducer, mainState } from "./reducers";

export const StateContext = createContext({});
export const DispatchContext = createContext({});

const GlobalContextProvider = ({ children }) => {
  const [state, dispatch] = useReducer(mainReducer, mainState);
  return (
    <StateContext.Provider value={state}>
      <DispatchContext.Provider value={dispatch}>
        {children}
      </DispatchContext.Provider>
    </StateContext.Provider>
  );
};

export default GlobalContextProvider;
