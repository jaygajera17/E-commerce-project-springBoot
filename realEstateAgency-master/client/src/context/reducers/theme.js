export const themeState = {
  selectedTheme: "dark",
};

export const themeReducer = (state, action) => {
  switch (action.type) {
    case "SET_THEME":
      if (action.payload) return { selectedTheme: action.payload };
      break;
    default:
      return state;
  }
};
