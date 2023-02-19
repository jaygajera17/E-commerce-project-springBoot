import { useState } from "react";
import styled, { css } from "styled-components";
import { IoChevronForward, IoChevronBack } from "react-icons/io5";
import { FiEdit } from "react-icons/fi";
import { AiFillDelete } from "react-icons/ai";

const CardWrapper = styled.div`
  width: 30%;
  min-width: 300px;
  overflow: hidden;
  background: ${({ theme }) => theme.backgroundVariant};
  margin: 1rem 0.5rem;
  @media screen and (max-width: 768px) {
    width: 45%;
  }
`;
const ImagesWrapper = styled.div`
  display: flex;
  width: 100%;
  height: 80%;
  height: 250px;
  align-items: center;
  justify-content: space-between;
  position: relative;
  cursor: pointer;
  overflow: hidden;
`;
const ImagesWrapperInner = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  position: absolute;
  max-height: 300px;
  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: 0.3s all ease-in-out;
    &:hover {
      transform: scale(1.2);
    }
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

const CardContent = styled.div`
  display: flex;
  flex-direction: column;
  padding: 1rem 2rem;
  span {
    margin: 0.25rem 0;
  }
  strong {
    transition: 0.3s;
    &:hover {
      color: ${({ theme }) => theme.primaryColor};
      transform: scale(1.02);
      cursor: pointer;
    }
  }
  div {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
`;

const Icons = styled.span``;
const IconsCss = css`
  font-size: 1.3rem;
  transition: 0.2s all ease-in-out;
  margin: 0 1rem;
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

function ListCard({ setSelectedHome, homeDetails }) {
  const [selectedImg, setSelectedImg] = useState(0);
  const { images, title, price } = homeDetails;
  const forward = () => setSelectedImg((selectedImg + 1) % images.length);
  const backward = () =>
    setSelectedImg(selectedImg === 0 ? images.length - 1 : selectedImg - 1);
  return (
    <CardWrapper className="list-card">
      <ImagesWrapper>
        <BackwardArrow onClick={backward} />
        <ImagesWrapperInner
          onClick={() => {
            setSelectedHome(homeDetails);
          }}
        >
          <img src={images[selectedImg]} alt="card" />
        </ImagesWrapperInner>
        <ForwardArrow onClick={forward} />
      </ImagesWrapper>
      <CardContent>
        <strong
          onClick={() => {
            setSelectedHome(homeDetails);
          }}
        >
          {title}
        </strong>
        <div>
          ${price}{" "}
          <Icons>
            <EditIcon />
            <DeleteIcon />
          </Icons>
        </div>
      </CardContent>
    </CardWrapper>
  );
}

export default ListCard;
