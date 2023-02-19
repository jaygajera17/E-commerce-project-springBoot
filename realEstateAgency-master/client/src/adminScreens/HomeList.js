import styled, { css } from "styled-components";
import { FiEdit } from "react-icons/fi";
import { AiFillDelete } from "react-icons/ai";

const Container = styled.div`
  width: 100%;
  position: relative;
`;
const Homes = styled.table`
  width: 100%;
  /* min-width: 800px; */
  table-layout: fixed;
  white-space: nowrap;
  border-collapse: collapse;
  overflow-x: auto;
  td {
    width: 12%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: 1.4rem;
    padding: 0.5rem 1rem;
    &.address-col {
      width: 28%;
    }
  }
  @media screen and (max-width: 768px) {
    table,
    thead,
    tbody,
    th,
    td,
    tr {
      display: block;
    }
    thead {
      position: absolute;
      top: -9999px;
      left: -9999px;
    }
    tr {
      /* border: 1px solid ${({ theme }) => theme.primaryText}; */
      /* width: 100%; */
      margin: 1rem 0;
      padding: 0 1rem;
    }
    td {
      /* Behave  like a "row" */
      width: 100%;
      border: none;
      border-bottom: 1px solid ${({ theme }) => theme.secondaryText};
      position: relative;
      padding-left: 50%;
      /* overflow: visible; */
      line-height: 1rem;
      /* padding: 0.5rem 1rem; */
      &.address-col {
        width: 100%;
      }
    }
    td:before {
      /* Now like a table header */
      position: absolute;
      /* Top/left values mimic padding */
      top: 6px;
      left: 6px;
      width: 45%;
      padding-right: 10px;
      white-space: nowrap;
      content: attr(data-label);
      text-transform: capitalize;
    }
  }
`;
const HomeListHeader = styled.thead`
  tr {
    display: flex;
    margin-top: 1rem;
    text-transform: capitalize;
    width: 100%;
  }

  td {
    border: 1px solid ${({ theme }) => theme.primaryText};
  }
`;
const Home = styled.tr`
  display: flex;
  td {
    border: 1px solid ${({ theme }) => theme.primaryText};
  }
`;

const HomeLink = styled.span`
  color: ${({ theme }) => theme.primaryText};
  text-decoration: none;
  &:hover {
    cursor: pointer;
    text-decoration: underline;
  }
`;
const Icons = styled.span`
  display: flex;
  justify-content: space-around;
  align-items: center;
`;
const IconsCss = css`
  font-size: 1.3rem;
  transition: 0.2s all ease-in-out;
  &:hover {
    cursor: pointer;
    transform: scale(1.2);
  }
`;
const EditIcon = styled(FiEdit)`
  ${IconsCss}
`;
const DeleteIcon = styled(AiFillDelete)`
  ${IconsCss}
  color: #ca0b00;
`;

function HomeList({ homesList, setSelectedHome, deleteHome }) {
  return (
    <Container>
      <Homes>
        <HomeListHeader>
          <tr>
            <td className="address-col">Address</td>
            <td>Price</td>
            <td>Type</td>
            <td>rooms</td>
            <td>washrooms</td>
            <td>size</td>
            <td>Actions</td>
          </tr>
        </HomeListHeader>
        <tbody>
          {homesList.map((home) => (
            <Home key={home._id}>
              <td className="address-col" data-label="Address">
                <HomeLink onClick={() => setSelectedHome(home)}>
                  {home.address}
                </HomeLink>
              </td>
              <td data-label="Price">{home.price}</td>
              <td data-label="Type">{home.type}</td>
              <td data-label="Rooms">{home.rooms}</td>
              <td data-label="washrooms">{home.washrooms}</td>
              <td data-label="size">{home.size}</td>
              <td data-label="actions">
                <Icons>
                  <EditIcon title="edit" />
                  <DeleteIcon title="delete" onClick={()=>deleteHome(home)} />
                </Icons>
              </td>
            </Home>
          ))}
        </tbody>
      </Homes>
    </Container>
  );
}

export default HomeList;
