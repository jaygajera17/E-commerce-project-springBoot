import { useState } from "react";
import styled, { css } from "styled-components";
import { useHistory } from "react-router-dom";
import { IoChevronForward, IoChevronBack } from "react-icons/io5";
import { BsDot } from "react-icons/bs";

const CardWrapper = styled.div`
  width: 100%;
  height: 500px;
  overflow: hidden;
  background: ${({ theme }) => theme.backgroundVariant};
  margin: 1rem 0;
`;
const ImagesWrapper = styled.div`
  display: flex;
  width: 100%;
  height: 60%;
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
      /* filter: brightness(0.8); */
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
  h2 {
    transition: 0.3s;
    &:hover {
      color: ${({ theme }) => theme.primaryColor};
      transform: scale(1.02);
      cursor: pointer;
    }
  }
`;

function ListCard({
  _id,
  images,
  title,
  address,
  price,
  type,
  date,
  rooms,
  washrooms,
  size,
  pets,
}) {
  let history = useHistory();
  const [selectedImg, setSelectedImg] = useState(0);
  const forward = () => setSelectedImg((selectedImg + 1) % images.length);
  const backward = () =>
    setSelectedImg(selectedImg === 0 ? images.length - 1 : selectedImg - 1);

  if (typeof images === "undefined") return <>undefiind</>;

  return (
    <CardWrapper className="list-card">
      <ImagesWrapper>
        <BackwardArrow onClick={backward} />
        <ImagesWrapperInner>
          <img
            src={"/" + images[selectedImg]}
            alt="card"
            onClick={() => history.push(`/homes/${_id}`)}
          />
        </ImagesWrapperInner>
        <ForwardArrow onClick={forward} />
      </ImagesWrapper>
      <CardContent>
        <h2 onClick={() => history.push(`/homes/${_id}`)}>{title}</h2>
        <span>${price}</span>
        <span>{address}</span>
        <span>
          {type}  <small>{date.substr(0,10)}</small>
        </span>
        <span>
          {rooms} BED <BsDot /> {washrooms} BATH <BsDot /> {size}FT²
        </span>
        <span>PETS : {pets ? " allowed" : " not allowed"}</span>
      </CardContent>
    </CardWrapper>
  );
}

export default ListCard;
