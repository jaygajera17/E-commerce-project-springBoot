import styled from "styled-components";
const SubNav = styled.div`
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: 1px solid ${({ theme }) => theme.secondaryText};
  overflow-x: auto;
  padding: 0 0.5rem;
`;

export const SubNavItem = styled.div`
  padding: 0.5rem 1rem;
  margin: 1.5rem 1rem 0;
  border-bottom: 2px solid transparent;
  color: ${({ theme }) => theme.secondaryText};
  white-space: nowrap;

  @media screen and (max-width: 480px) {
    margin: 1.5rem 0 0;
    padding: 0.5rem;
  }
  &:hover {
    border-color: ${({ theme }) => theme.primaryText};
    cursor: pointer;
  }
  &.selected {
    border-color: ${({ theme }) => theme.primaryColor};
    color: ${({ theme }) => theme.primaryText};
  }

  svg {
    font-size: 1.2rem;
    vertical-align: middle;
    margin-right: 0.3rem;
  }
  span {
    vertical-align: middle;
  }
`;

function SubNavigation({ children }) {
  return <SubNav>{children}</SubNav>;
}

export default SubNavigation;
