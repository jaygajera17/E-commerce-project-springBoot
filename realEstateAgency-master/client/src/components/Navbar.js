import React, { useEffect, useState, useContext, useRef } from "react";
import styled, { css } from "styled-components/macro";
import { Link, useHistory } from "react-router-dom";
import { menuData } from "../data/MenuData";
import { Button } from "./Button";
import { FaBars } from "react-icons/fa";
import { DispatchContext, StateContext } from "../context/GlobalContext";
import { USER_LOGOUT } from "../context/constants/userConstants";
import { FaSun, FaMoon } from "react-icons/fa";

const Nav = styled.nav`
  height: 60px;
  display: flex;
  justify-content: space-between;
  padding: 1rem 1rem 1rem 2rem;
  z-index: 100;
  position: fixed;
  width: 100%;
  background: ${({ atTop, atHome, theme }) =>
    atTop && atHome ? "transparent" : theme.backgroundVariant};
`;

const NavLink = css`
  color: ${({ theme }) => theme.primaryText};
  display: inline-block;
  align-items: center;
  padding: 0 1rem;
  height: 100%;
  cursor: pointer;
  text-decoration: none;
`;

const Logo = styled(Link)`
  ${NavLink}
  font-style: italic;
`;
const MenuBars = styled(FaBars)`
  display: none;
  color: ${({ theme }) => theme.primaryText};
  height: 40px;
  width: 40px;
  position: absolute;
  top: 0;
  right: 0;
  transform: translate(-50%, 25%);
  cursor: pointer;
  @media screen and (max-width: 768px) {
    display: block;
  }
`;
const NavMenu = styled.div`
  display: flex;
  align-items: center;
  @media screen and (max-width: 768px) {
    display: none;
  }
`;

const NavMenuLinks = styled(Link)`
  ${NavLink}
`;

const NavBtn = styled.div`
  display: flex;
  align-items: center;
  margin-right: 24px;
  @media screen and (max-width: 768px) {
    display: none;
  }
`;

const UserProfile = styled.div`
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: #000;
  background-image: url(${(props) => props.img});
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  margin-left: 1rem;

  position: relative;
  &:hover {
    cursor: pointer;
  }
`;
const ProfileMenu = styled.div`
  position: absolute;
  top: 45px;
  right: -10px;
  /* left: -100%; */
  min-width: 10rem;
  background-color: ${({ theme }) => theme.backgroundVariant2};
  background-clip: padding-box;
  border: 1px solid rgba(0, 0, 0, 0.15);
  border-radius: 0.25rem;
  padding: 0.25rem 0;
`;
const MenuItem = styled.div`
  padding: 0.25rem 1.5rem;
  line-height: 1.5rem;
  color: ${({ theme }) => theme.primaryText};
  font-size: 1rem;
  margin: 0.25rem 0;
  &:hover {
    background-color: ${({ theme }) => theme.backgroundVariant};
  }
`;

// Dark theme button
const DarkThemeBtn = styled.div`
  margin: 0 1rem;
  font-size: 1.4rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  .sun {
    color: #fff;
  }
  .moon {
    color: #000;
  }
`;

function Navbar({ toggleDropdown, setTheme, theme, atHome }) {
  const { user } = useContext(StateContext);
  const dispatch = useContext(DispatchContext);
  const history = useHistory();
  const dropdownRef = useRef(null);
  const [showUserOptions, setShowUserOptions] = useState(false);
  const [atTop, setAtTop] = useState(true); //navbar position
  const logout = () => {
    dispatch({ type: USER_LOGOUT });
  };

  useEffect(() => {
    let eventListener = window.addEventListener("scroll", (e) => {
      var scrolled = document.scrollingElement.scrollTop;
      if (scrolled >= 120) {
        if (atTop) setAtTop(false);
      } else {
        if (!atTop) setAtTop(true);
      }
    });

    return () => window.removeEventListener("scroll", eventListener);
  }, [atTop]);

  useEffect(() => {
    function handleClickOutside(event) {
      if (
        showUserOptions &&
        dropdownRef.current &&
        !dropdownRef.current.contains(event.target)
      ) {
        setShowUserOptions(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [dropdownRef, showUserOptions]);

  return (
    <Nav atTop={atTop} atHome={atHome}>
      <Logo to="/">Home</Logo>
      <MenuBars onClick={toggleDropdown} />
      <NavMenu>
        {menuData.map((item, index) => (
          <NavMenuLinks to={item.link} key={index}>
            {item.title}
          </NavMenuLinks>
        ))}
      </NavMenu>
      <NavBtn>
        {/* <DarkThemeBtn
          onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
        >
          {theme === "light" ? (
            <FaMoon className="moon" />
          ) : (
            <FaSun className="sun" />
          )}
        </DarkThemeBtn> */}
        {user.isAdmin && (
          <Button primary="true" to="/addhome">
            Add new Property
          </Button>
        )}

        {user && user.auth ? (
          <UserProfile
            onClick={() => setShowUserOptions(!showUserOptions)}
            img={user.profileImg}
          >
            {showUserOptions && (
              <ProfileMenu ref={dropdownRef}>
                {/* {user.isAdmin && (
                  <MenuItem onClick={() => history.push("/admin")}>
                    Dashboard
                  </MenuItem>
                )} */}
                <MenuItem onClick={() => history.push("/admin")}>
                  Dashboard
                </MenuItem>
                <MenuItem onClick={() => history.push("/user")}>
                  Profile
                </MenuItem>
                {/* <MenuItem onClick={() => history.push("/user")}>
                  Preferences
                </MenuItem> */}
                <MenuItem onClick={logout}>Logout</MenuItem>
              </ProfileMenu>
            )}
          </UserProfile>
        ) : (
          <Button
            css={`
              margin-left: 1rem;
            `}
            primary="true"
            to="/login"
          >
            Login
          </Button>
        )}
      </NavBtn>
    </Nav>
  );
}

export default Navbar;
