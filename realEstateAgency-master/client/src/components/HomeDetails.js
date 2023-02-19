import { useState } from "react";
import styled, { css } from "styled-components";
import { BsDot } from "react-icons/bs";
import { FaBed, FaBath } from "react-icons/fa";
import { GiResize } from "react-icons/gi";
import { Button } from "../components/Button";
import {
  IoChevronForward,
  IoChevronBack,
  IoArrowBackOutline,
} from "react-icons/io5";

const Container = styled.div`
  margin-top: calc(60px + 1rem);
  padding: 0 calc((100vw - 1300px) / 2);
`;

const Header = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  background: ${({ theme }) => theme.backgroundVariant};
  padding: 2rem;
`;

const ulStyles = css`
  display: flex;
  list-style-type: none;
  justify-content: space-between;
  align-items: center;
  li {
    margin-right: 0.5rem;
  }
`;
const HeaderFirstSection = styled.div`
  display: flex;
  align-items: center;
  ul {
    ${ulStyles}
    margin-bottom: 0.5rem;
    .home-price {
      font-size: 1.3rem;
    }
    .time {
      color: ${({ theme }) => theme.secondaryText};
    }
  }
  .home-address {
    font-size: 0.9rem;
  }
`;
const BackButton = styled(IoArrowBackOutline)`
  font-size: 2.2rem;
  cursor: pointer;
  margin-right: 1rem;
  transition: 0.3s all ease-in-out;
  &:hover {
    transform: scale(1.2);
  }
`;
const HeaderSecondSection = styled.div`
  ul {
    ${ulStyles}
    li {
      margin-right: 1.5rem;
    }
  }
`;

const Body = styled.div`
  width: 100%;
  display: flex;
  margin: 1rem 0;
  /* justify-content: space-between; */
  /* background: ${({ theme }) => theme.backgroundVariant}; */
`;
const ImageSection = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 500px;
  width: 600px;
  position: relative;
  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    position: absolute;
  }
`;
const arrowStyles = css`
  width: 40px;
  height: 40px;
  z-index: 2;
  color: ${({ theme }) => theme.headingColor};
  cursor: pointer;
  background: ${({ theme }) => theme.background};
  border-radius: 50px;
  padding: 10px;
  margin: 1rem;
  user-select: none;
  transition: 0.3s;

  &:hover {
    background: ${({ theme }) => theme.primaryColor};
    transform: scale(1.25);
  }
`;
const ForwardArrow = styled(IoChevronForward)`
  ${arrowStyles}
`;
const BackwardArrow = styled(IoChevronBack)`
  ${arrowStyles}
`;

const ContactSection = styled.form`
  width: 400px;
  margin: 0 auto;
  h2 {
    margin-bottom: 1rem;
  }
`;
const inputCss = css`
  width: 100%;
  margin-bottom: 1.5rem;
  padding: 0.3rem 0.7rem;
  line-height: 1.5rem;
  border-radius: 0.25rem;
  transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
  cursor: text;
  outline: none;
  background: ${({ theme }) => theme.background};
  color: ${({ theme }) => theme.primaryText};
  border: 1px solid
    ${({ theme }) => (theme.name === "dark" ? "#ced4da" : "#000")};
  &::placeholder {
    color: ${({ theme }) => (theme.name === "dark" ? "#ced4da" : "#000")};
    font-weight: bold;
  }
  &:focus {
    background: ${({ theme }) => theme.background};
    box-shadow: 0 0 5px ${({ theme }) => theme.primaryText};
  }
`;
const Input = styled.input`
  ${inputCss}
`;
const TextArea = styled.textarea`
  ${inputCss}
`;

const HomeDetailsSection = styled.div`
  display: flex;
  justify-content: space-between;
`;
const LeftColumn = styled.div`
  width: 50%;
  h2 {
    font-size: 1.3rem;
    font-weight: 400;
    margin-bottom: 1rem;
  }
  ul {
    list-style: none;
    padding: 1rem;
    background: ${({ theme }) => theme.backgroundVariant};
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 1rem;
    width: 100%;
    li {
      /* margin: 0.5rem 0; */
    }
  }
  p {
    margin: 1rem 0;
  }
`;
const RightColumn = styled.div``;

function HomeDetails({ home, back }) {
  const [selectedImg, setSelectedimg] = useState(0);
  const [extendReadmore, setExtendReadmore] = useState(false);

  const nextImg = () => setSelectedimg((selectedImg + 1) % home.images.length);
  const prevImg = () =>
    setSelectedimg(
      selectedImg === 0 ? home.images.length - 1 : selectedImg - 1
    );

  if (!home) {
    return (
      <Container>
        <Header>
          <BackButton onClick={back} />
        </Header>
        <h1>No Home found</h1>
      </Container>
    );
  }
  return (
    <Container>
      <Header>
        <HeaderFirstSection>
          <BackButton onClick={back} />
          <div>
            <ul>
              <li className="home-price">${home.price}</li>
              <li>
                <BsDot />
              </li>
              <li> {home.type}</li>
              <li>
                <BsDot />
              </li>
              <li className="time"> {home.date.substr(0,10)}</li>
            </ul>
            <span className="home-address">{home.address}</span>
          </div>
        </HeaderFirstSection>
        <HeaderSecondSection>
          <ul>
            <li>
              <FaBed /> {home.rooms} Bed
            </li>
            <li>
              <FaBath /> {home.washrooms} Bath
            </li>
            <li>
              <GiResize /> {home.size} FT²
            </li>
          </ul>
        </HeaderSecondSection>
      </Header>
      <Body>
        <ImageSection>
          <BackwardArrow onClick={nextImg} />
          <img src={`/${home.images[selectedImg]}`} alt={home.address} />
          <ForwardArrow onClick={prevImg} />
        </ImageSection>
        <ContactSection>
          <h2>Contact Property</h2>
          <Input placeholder="Your Name" />

          <Input placeholder="Your Email" />

          <Input placeholder=" Your Phone" />
          <TextArea placeholder="Type your message here" rows={7}></TextArea>
          <Button type="submit">Submit</Button>
        </ContactSection>
      </Body>
      <HomeDetailsSection>
        <LeftColumn>
          <h2>About {home.title}</h2>
          <div className="details">
            <ul>
              <li>
                <strong>Property Type:</strong>{" "}
                {home.type ? home.type : "No Info"}
              </li>
              <li>
                <strong>Parking : </strong>
                {home.parking ? home.parking : "No Info"}
              </li>

              <li>
                <strong>Furnished :</strong>{" "}
                {home.furnished ? home.furnished : "No Info"}
              </li>
              <li>
                <strong>Year Built :</strong>{" "}
                {home.yearBuilt ? home.yearbuilt : "No Info"}
              </li>
            </ul>
            <p>
              {home.details.length > 250 && !extendReadmore ? (
                <>{home.details.substr(0, 250)}......</>
              ) : (
                home.details
              )}
              <Button onClick={() => setExtendReadmore(!extendReadmore)}>
                Read {extendReadmore ? "less" : "more"}
              </Button>
            </p>
          </div>
        </LeftColumn>
        <RightColumn></RightColumn>
      </HomeDetailsSection>
    </Container>
  );
}

export default HomeDetails;
