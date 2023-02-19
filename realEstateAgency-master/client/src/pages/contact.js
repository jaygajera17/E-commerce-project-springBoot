import Layout from "../components/Layout";
import styled, { css } from "styled-components";
import { FaMobileAlt, FaMapMarkerAlt } from "react-icons/fa";
import { AiOutlineMail } from "react-icons/ai";
import Slide from "react-reveal/Slide";

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

const Button = styled.button`
  ${inputCss}
  cursor: pointer;
  &:hover {
    background: ${({ theme }) => theme.primaryColor};
    color: #fff;
  }
`;

const RightColumn = styled.div`
  p {
    color: ${({ theme }) => theme.secondaryText};
  }
  ul {
    list-style-type: none;
    margin-top: 2rem;
    li {
      margin-bottom: 1rem;
      display: flex;
      align-items: center;
      cursor: pointer;
      &:hover {
        color: ${({ theme }) => theme.primaryColor};
      }
    }
  }
`;

function Contact() {
  return (
    <Layout>
      <Container>
        <FormContainer>
          <Slide left>
            <h1>Contact Us</h1>

            <Input placeholder="Your Name" />

            <Input placeholder="Your Email" />

            <Input placeholder=" Your Phone" />
            <Input placeholder="Subject (optional)" />
            <TextArea placeholder="Type your message here" rows={7}></TextArea>
            <Button type="submit">Submit</Button>
          </Slide>
        </FormContainer>
        <RightColumn>
          <Slide right>
            <h2>REST - Personal Real Estate Corporation</h2>
            <p>REST Pacafic Realty Ltd.</p>
            <ul>
              <li>
                <FaMapMarkerAlt /> 1234 12 street, surrey BC V4C 123
              </li>
              <li>
                <FaMobileAlt /> 6043333333
              </li>
              <li>
                <AiOutlineMail /> contact@rest.ca
              </li>
            </ul>
          </Slide>
        </RightColumn>
      </Container>
    </Layout>
  );
}

export default Contact;
