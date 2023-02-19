import React from "react";
import styled from "styled-components/macro";
import ListCard from "./components/ListCard";

const Column = styled.div`
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: center;
`;

function HomeGrid({ homesList, setSelectedHome }) {
  return (
    <Column>
      {homesList.map((home) => (
        <ListCard
          key={home._id}
          homeDetails={home}
          setSelectedHome={setSelectedHome}
        />
      ))}
    </Column>
  );
}

export default HomeGrid;
