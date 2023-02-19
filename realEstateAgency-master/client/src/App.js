import { useContext, useEffect } from "react";
import { Route, Switch } from "react-router-dom";
import { StateContext, DispatchContext } from "./context/GlobalContext";
import {
  USER_LOGIN_SUCCESS,
  USER_LOGIN_REQUEST,
  USER_LOGIN_FAIL,
} from "./context/constants/userConstants";
import Index from "./pages";
import NotFound from "./pages/404";
import About from "./pages/about";
import Contact from "./pages/contact";
import Homes from "./pages/homes";
import Admin from "./pages/admin";
import Login from "./pages/login";
import Register from "./pages/register";
import PrivateRoute from "./components/PrivateRoute";
import axios from "axios";
import User from "./pages/user";
import Addhome from "./pages/addhome";
function App() {
  const state = useContext(StateContext);
  const dispatch = useContext(DispatchContext);

  useEffect(() => {
    async function getUserData() {
      const token = localStorage.getItem("userToken");
      if (token && !state.user.auth) {
        dispatch({
          type: USER_LOGIN_REQUEST,
        });
        try {
          const { status, data } = await axios.get("/api/users/profile", {
            headers: {
              Authorization: "Bearer " + token,
            },
          });
          dispatch({
            type: USER_LOGIN_SUCCESS,
            payload: { ...data, auth: true },
          });
        } catch (err) {
          dispatch({
            type: USER_LOGIN_FAIL,
            error: err,
          });
        }
      }
    }
    getUserData();
  }, [dispatch, state.user.auth]);

  return (
    <Switch>
      <Route exact path="/" component={Index} />
      <Route path="/about" component={About} />
      <Route path="/contact" component={Contact} />
      <Route path="/homes/:id" component={Homes} />
      <Route path="/homes" component={Homes} />
      <Route path="/login" component={Login} />
      <Route path="/register" component={Register} />
      <PrivateRoute path="/user" component={User} />
      {/* <Route path="/user/:item" component={User} /> */}
      <PrivateRoute path="/admin" component={Admin} />
      <PrivateRoute path="/addhome" component={Addhome} />
      <Route component={NotFound} />
    </Switch>
  );
}

export default App;
