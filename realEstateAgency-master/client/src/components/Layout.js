import { useState, useContext } from "react";
import styled, { ThemeProvider } from "styled-components";
import GlobalStyles, { themes } from "../globalStyles";
import Helmet from "react-helmet";
import Dropdown from "./Dropdown";
import Footer from "./Footer";
import Navbar from "./Navbar";
import { StateContext, DispatchContext } from "../context/GlobalContext";

const LayoutContainer = styled.div`
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  /* justify-content: space-between; */
  background: ${({ theme }) => theme.background};
  color: ${({ theme }) => theme.primaryText};
`;
const Content = styled.div`
  height: 100%;
  flex: 1;
  position: relative;
`;

function Layout({ atHome, children, hideFooter, hideNav }) {
  const { theme } = useContext(StateContext);
  const dispatch = useContext(DispatchContext);
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const toggleDropdown = () => setIsDropdownOpen(!isDropdownOpen);
  const setTheme = (payload) => {
    dispatch({
      type: "SET_THEME",
      payload,
    });
  };
  return (
    <ThemeProvider theme={themes[theme.selectedTheme]}>
      <Helmet>
        <style type="text/css">{`
          @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');  
    `}</style>
      </Helmet>
      <GlobalStyles />
      <LayoutContainer>
        {hideNav !== "true" && (
          <Navbar
            toggleDropdown={toggleDropdown}
            setTheme={setTheme}
            theme={theme.selectedTheme}
            atHome={atHome}
          />
        )}

        <Dropdown isOpen={isDropdownOpen} toggle={toggleDropdown} />
        <Content>{children}</Content>
        {!hideFooter && <Footer />}
      </LayoutContainer>
    </ThemeProvider>
  );
}

export default Layout;
