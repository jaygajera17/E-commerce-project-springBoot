import combineReducers from "react-combine-reducers";
import { homesReducer, homesState } from "./homes";
import { mapReducer, mapState } from "./map";
import { themeState, themeReducer } from "./theme";
import { userState, userReducer } from "./user";

export const [mainReducer, mainState] = combineReducers({
  map: [mapReducer, mapState],
  homesList: [homesReducer, homesState],
  theme: [themeReducer, themeState],
  user: [userReducer, userState],
});
