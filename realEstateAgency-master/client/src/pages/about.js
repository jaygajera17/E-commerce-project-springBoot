import Layout from "../components/Layout";
import styled from "styled-components";
import InfoSection from "../components/InfoSection";
import { AboutUsSection } from "../data/AboutUsData";

const Container = styled.div`
  margin-top: 60px;
  width: 100%;
`;

function About() {
  return (
    <Layout>
      <Container>
        <InfoSection {...AboutUsSection} />
      </Container>
    </Layout>
  );
}

export default About;
