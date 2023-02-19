import React from "react";
import styled from "styled-components";

const Container = styled.div`
  margin-top: 60px;
  width: 100%;
  padding: 3rem calc((100vw - 1300px) / 2);
  display: flex;
  justify-content: space-between;
  /* align-items: center; */
  flex-wrap: wrap;
`;

const FormContainer = styled.form`
  width: 50%;
  display: flex;
  flex-direction: column;
  @media screen and (max-width: 768px) {
    width: 90%;
  }
  @media screen and (max-width: 48px) {
    width: 100%;
  }
  h1 {
    margin-bottom: 1rem;
  }
`;
const inputCss = css`
  width: 100%;
  margin-left: 1.5rem;
  margin-bottom: 1.5rem;
  padding: 0.3rem 0.7rem;
  line-height: 1.5rem;
  border: 1px solid #ced4da;
  border-radius: 0.25rem;
  transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
  cursor: text;
  outline: none;
  background: ${({ theme }) => theme.background};
  color: ${({ theme }) => theme.primaryText};
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

const Button = styled.button`
  ${inputCss}
  cursor: pointer;
  &:hover {
    background: ${({ theme }) => theme.primaryColor};
    color: #fff;
  }
`;

function HomeAdd() {
  return (
    <Container>
      <FormContainer>
        <Input placeholder="Your Name" />
        <Input placeholder="Your Email" />
      </FormContainer>
    </Container>
  );
}

export default HomeAdd;
