export const mapState = {
  selectedItem: null,
};

export const mapReducer = (state, action) => {
  switch (action.type) {
    case "SET_SELECTEDITEM":
      if (action.payload) return { ...state, selectedItem: action.payload };
      break;
    case "REMOVE_SELECTEDITEM":
      return { ...state, selectedItem: null };
    default:
      return state;
  }
};
