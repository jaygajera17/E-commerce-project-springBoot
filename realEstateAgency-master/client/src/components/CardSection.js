import React from "react";
import styled from "styled-components/macro";
import Card from "./Card";
import Fade from "react-reveal/Fade";
import { Button } from "./Button";

const Section = styled.section`
  width: 100%;
  height: 100%;
  padding: 4rem 0;
  background: ${({ theme }) => theme.background};
  h1 {
    color: ${({ theme }) => theme.headingColor};
    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 2rem;
  }
`;
const Container = styled.div`
  padding: 3rem calc((100vw - 1300px) / 2);
  display: grid;
  grid-template-columns: 1fr 1fr;
  /* grid-template-rows: 600px; */
  @media screen and (max-width: 768px) {
    grid-template-columns: 1fr;
  }
`;
const ColumnLeft = styled.div`
  padding: 2rem 0.5rem;
  position: relative;
  @media screen and (min-width: 768px) {
    top: -10%;
  }
`;
const ColumnRight = styled.div`
  padding: 2rem 0.5rem;
  position: relative;
  @media screen and (min-width: 768px) {
    top: 10%;
  }
`;

function CardSection({ itemOne, itemTwo, header }) {
  return (
    <Section>
      <h1>{header}</h1>
      <Container>
        <ColumnLeft>
          <Fade top>
            <Card image={itemOne.images[0]} alt={itemOne.title} buttonLabel="View details" buttonLink={`/homes/${itemOne._id}`} />
          </Fade>
        </ColumnLeft>
        <ColumnRight>
          <Fade bottom>
            <Card image={itemTwo.images[0]} alt={itemTwo.title} buttonLabel="View details" buttonLink={`/homes/${itemTwo._id}`} />
          </Fade>
        </ColumnRight>
      </Container>
      <Button
        to="/homes"
        css={`
          margin: 0 auto;
        `}
      >
        View More
      </Button>
    </Section>
  );
}

export default CardSection;
