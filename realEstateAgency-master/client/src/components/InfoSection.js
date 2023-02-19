import React from "react";
import styled from "styled-components";
import { Button } from "./Button";
import Slide from "react-reveal/Slide";

const Section = styled.section`
  width: 100%;
  height: 100%;
  padding: 4rem 0;
`;
const Container = styled.div`
  padding: 3rem calc((100vw - 1300px) / 2);
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 600px;

  @media screen and (max-width: 768px) {
    grid-template-columns: 1fr;
  }
`;
const ColumnLeft = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  line-height: 1.4;
  padding: 1rem 2rem;
  order: ${({ reverse }) => (reverse ? 2 : 1)};
  color: ${({ theme }) => theme.headingColor};
  h1 {
    margin-bottom: 1rem;
    font-size: clamp(1.5rem, 6vw, 2rem);
  }
  p {
    margin-bottom: 2rem;
    color: ${({ theme }) => theme.textColor};
    font-size: 1.2rem;
  }
`;
const ColumnRight = styled.div`
  padding: 1rem 2rem;
  order: ${({ reverse }) => (reverse ? 1 : 2)};
  display: flex;
  justify-content: center;
  align-items: center;
  @media screen and (max-width: 768px) {
    order: ${({ reverse }) => (reverse ? 2 : 1)};
  }

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    @media screen and (max-width: 768px) {
      width: 90%;
      height: 90%;
    }
  }
`;

function InfoSection({
  heading,
  paragraphOne,
  paragraphTwo,
  buttonLabel,
  buttonLink,
  image,
  reverse,
  delay,
}) {
  return (
    <Section reverse={reverse}>
      <Container>
        <ColumnLeft reverse={reverse}>
          <Slide right={reverse} left={!reverse}>
            <h1>{heading}</h1>
            <p>{paragraphOne}</p>
            <p>{paragraphTwo}</p>
            <Button to={buttonLink}>{buttonLabel}</Button>
          </Slide>
        </ColumnLeft>
        <ColumnRight reverse={reverse}>
          <Slide right={!reverse} left={reverse}>
            <img src={image} alt="home" />
          </Slide>
        </ColumnRight>
      </Container>
    </Section>
  );
}

export default InfoSection;
