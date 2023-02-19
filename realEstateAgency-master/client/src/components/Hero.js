import React, { useState, useRef, useEffect } from "react";
import styled, { css } from "styled-components/macro";
import { Button } from "./Button";
import { IoMdArrowRoundForward } from "react-icons/io";
import { IoArrowForward, IoArrowBack } from "react-icons/io5";
import Fade from "react-reveal/Fade";

const HeroSection = styled.section`
  height: 100vh;
  max-height: 1100px;
  position: relative;
  overflow: hidden;
`;

const HeroWrapper = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  position: relative;
`;

const HeroSlide = styled.div`
  z-index: 1;
  width: 100%;
  height: 100%;
`;
const HeroSlider = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
`;
const HeroImage = styled.img`
  position: absolute;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  object-fit: cover;
  /* filter: brightness(90%); */
`;
const HeroContent = styled.div`
  position: relative;
  z-index: 10;
  display: flex;
  flex-direction: column;
  max-width: 1600px;
  width: calc(100% - 100px);
  color: #fff;

  h1 {
    font-size: clamp(1rem, 8vw, 3.5rem);
    font-weight: 400;
    text-transform: uppercase;
    text-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
    text-align: left;
    margin-bottom: 0.8rem;
    text-shadow: 0 0 5px #000;
  }
  p {
    text-shadow: 0 0 5px #000;
    text-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
    margin-bottom: 0.2rem;
  }
`;
const Arrow = styled(IoMdArrowRoundForward)`
  margin-left: 0.5rem;
`;

const arrowButtons = css`
  width: 50px;
  height: 50px;
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
    transform: scale(1.05);
  }
`;

const SliderButtons = styled.div`
  position: absolute;
  bottom: 50px;
  right: 50px;
  display: flex;
  z-index: 10;
`;
const PrevArrow = styled(IoArrowBack)`
  ${arrowButtons}
`;
const NextArrow = styled(IoArrowForward)`
  ${arrowButtons}
`;

const Hero = ({ slides }) => {
  const [current, setCurrent] = useState(0);
  const length = slides.length;
  const timeout = useRef(null);

  const nextSlide = () => {
    if (timeout.current) clearTimeout(timeout.current);
    setCurrent((current + 1) % length);
  };
  const previousSlide = () => {
    if (timeout.current) clearTimeout(timeout.current);
    setCurrent(current === 0 ? length - 1 : current - 1);
  };

  useEffect(() => {
    //   timeout.current = setTimeout(nextSlide, 3000);
    //   return () => {
    //     if (timeout.current) clearTimeout(timeout.current);
    //   };
  }, [current, length]);

  if (slides.length === 0) return null;
  return (
    <HeroSection>
      <HeroWrapper>
        <HeroSlide>
          <HeroSlider>
            <HeroImage src={slides[current].image} alt={slides[current].alt} />
            <HeroContent>
              <Fade right>
                <h1>{slides[current].title}</h1>
                <p>{slides[current].price}</p>
                <Button
                  primary="true"
                  to={slides[current].path}
                  css={`
                    max-width: 160px;
                  `}
                >
                  {slides[current].label}
                  <Arrow />
                </Button>
              </Fade>
            </HeroContent>
          </HeroSlider>
        </HeroSlide>
        <SliderButtons>
          <PrevArrow onClick={previousSlide} />
          <NextArrow onClick={nextSlide} />
        </SliderButtons>
      </HeroWrapper>
    </HeroSection>
  );
};

export default Hero;
