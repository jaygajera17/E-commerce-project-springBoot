import React from "react";
import styled from "styled-components";
import { FaFacebook, FaInstagram, FaLinkedin } from "react-icons/fa";

const FooterSection = styled.footer`
  width: 100%;
  background: ${({ theme }) => theme.backgroundVariant};
`;
const Container = styled.div`
  padding: 3rem calc((100% - 1300px) / 2);
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
`;
const ColumnLeft = styled.div`
  font-size: 2rem;
  color: ${({ theme }) => theme.headingColor};
  display: flex;
  flex-direction: column;
  justify-content: space-between;
`;
const ColumnRight = styled.div`
  h3 {
    color: ${({ theme }) => theme.headingColor};
    &:hover {
      cursor: pointer;
      color: ${({ theme }) => theme.primaryColor};
    }
  }
  div {
    margin: 1.5rem;
  }
  ul {
    padding: 0;
    list-style-type: none;
    li {
      margin: 0.4rem 0;
      color: ${({ theme }) => theme.textColor};
      &:hover {
        color: ${({ theme }) => theme.primaryColor};
        cursor: pointer;
      }
    }
  }
`;
const SocialLinks = styled.div`
  height: 100px;
  color: ${({ theme }) => theme.primaryColor};
  font-size: 2rem;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  svg {
    margin: 0 0.4rem;
    &:hover {
      cursor: pointer;
      color: ${({ theme }) => theme.headingColor};
    }
  }
`;

function Footer() {
  return (
    <FooterSection>
      <Container>
        <ColumnLeft>
          <h1>Let's find your dream Home</h1>
          <SocialLinks>
            <FaFacebook />
            <FaInstagram />
            <FaLinkedin />
          </SocialLinks>
        </ColumnLeft>
        <ColumnRight>
          <div>
            <h3>Contact Us</h3>
            <ul>
              <li>FAQs</li>
              <li>Support</li>
            </ul>
          </div>
          <div>
            <h3>Offices</h3>
            <ul>
              <li>United States</li>
              <li>Europe</li>
              <li>Canada</li>
            </ul>
          </div>
        </ColumnRight>
      </Container>
    </FooterSection>
  );
}

export default Footer;
