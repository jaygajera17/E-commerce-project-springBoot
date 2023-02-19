import {
  HOME_LIST_REQUEST,
  HOME_LIST_SUCCESS,
  HOME_LIST_FAIL,
  HOME_LIST_USER_REQUEST,
  HOME_LIST_USER_SUCCESS,
  HOME_LIST_USER_FAIL,
  HOME_DELETE_REQUEST,
  HOME_DELETE_SUCCESS,
  HOME_DELETE_FAIL,
} from "../constants/homesConstants";

export const homesState = {
  homes: [],
  userHomes:[]
};

export const homesReducer = (state, action) => {
  switch (action.type) {
    case HOME_LIST_REQUEST:
      return { ...state,loading: true, homes: [] };
    case HOME_LIST_SUCCESS:
      return {...state, loading: false, homes: action.payload };
    case HOME_LIST_FAIL:
      return {...state, loading: false, homes: [], error: action.payload };
    //user home
    case HOME_LIST_USER_REQUEST:
      return {...state, loading: true, userHomes: [] };
    case HOME_LIST_USER_SUCCESS:
      return {...state, loading: false, userHomes: action.payload };
    case HOME_LIST_USER_FAIL:
      return {...state, loading: false, userHomes: [], error: action.payload };
    //delete home
    case HOME_DELETE_REQUEST:
      return {...state, loading: true };
    case HOME_DELETE_SUCCESS:
      return {...state, loading: false, homes:state.homes.filter(home=>home._id !== action.payload._id), userHomes:state.userHomes.filter(home=>home._id !== action.payload._id) };
    case HOME_DELETE_FAIL:
      return {...state, loading: false, error: action.payload };
    default:
      return state;
  }
};
