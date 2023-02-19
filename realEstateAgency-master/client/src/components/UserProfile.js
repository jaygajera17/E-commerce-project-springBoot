import { useContext } from "react";
import styled from "styled-components";
import { StateContext } from "../context/GlobalContext";

const ProfileContainer = styled.div`
  display: flex;
  justify-content: space-evenly;
  align-items: center;
`;
const ProfileImg = styled.img`
  width: 15rem;
`;
const UserDetails = styled.div`
  h3 {
    font-size: 2rem;
  }
`;

function UserProfile() {
  const { user } = useContext(StateContext);
  // const dispatch = useContext(DispatchContext);
  return (
    <ProfileContainer>
      <ProfileImg src={user.profileImg} alt={user.name} />
      <UserDetails>
        <h3>{user.name}</h3>
        <span>{user.email}</span>
      </UserDetails>
    </ProfileContainer>
  );
}

export default UserProfile;
