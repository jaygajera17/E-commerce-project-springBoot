import { useContext } from "react";
import styled, { useTheme } from "styled-components";
import { DispatchContext } from "../context/GlobalContext";
import { FaSun, FaMoon } from "react-icons/fa";

const PreferencesContainer = styled.div`
  display: flex;
  flex-direction: column;
`;

const PreferencesItem = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: ${({ theme }) => theme.backgroundVariant};
  margin: 0.5rem 0;
  padding: 0.5rem;
  border-radius: 0.5rem;
`;
const ItemName = styled.span``;
const DarkThemeBtn = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0.3rem 0.5rem;
  margin-left: 1rem;
  font-size: 1.4rem;
  .sun {
    color: #fff;
  }
  .moon {
    color: #000;
  }
`;
const ToggleSwitch = styled.label`
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  margin: 0 0.3rem;
  input {
    opacity: 0;
    width: 0;
    height: 0;
    &:checked + .slider {
      background-color: ${({ theme }) => theme.background};
    }
    &:focus + .slider {
      box-shadow: 0 0 1px ${({ theme }) => theme.backgroundVariant};
    }
    &:checked + .slider:before {
      -webkit-transform: translateX(26px);
      -ms-transform: translateX(26px);
      transform: translateX(26px);
    }
  }
`;

const Slider = styled.span`
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: 0.4s;
  transition: 0.4s;
  border-radius: 34px;
  &:before {
    position: absolute;

    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: ${({ theme }) => theme.backgroundVariant};
    -webkit-transition: 0.4s;
    transition: 0.4s;
    border-radius: 50%;
  }
`;

function UserPreferences() {
  // const { user } = useContext(StateContext);
  const dispatch = useContext(DispatchContext);
  const theme = useTheme();
  const setTheme = (payload) => {
    dispatch({
      type: "SET_THEME",
      payload,
    });
  };
  return (
    <PreferencesContainer>
      <PreferencesItem>
        <ItemName>Theme</ItemName>
        <DarkThemeBtn>
          <FaSun className="sun" />
          <ToggleSwitch htmlFor="darkmodetoggler">
            <input
              type="checkbox"
              checked={theme.name === "dark"}
              onChange={() =>
                setTheme(theme.name === "dark" ? "light" : "dark")
              }
              id="darkmodetoggler"
            />
            <Slider className="slider"></Slider>
          </ToggleSwitch>
          <FaMoon className="moon" />
        </DarkThemeBtn>
      </PreferencesItem>
    </PreferencesContainer>
  );
}

export default UserPreferences;
