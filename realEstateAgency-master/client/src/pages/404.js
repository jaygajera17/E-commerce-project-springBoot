import Layout from "../components/Layout";
import styled from "styled-components";

const Container = styled.div`
  margin-top: 60px;
  width: 100%;
  padding: 3rem calc((100vw - 1300px) / 2);
  color: ${({ theme }) => theme.primaryText};
`;

function NotFound() {
  return (
    <Layout>
      <Container>
        <h1>404, Not Found</h1>
        <h2>Please try another Link</h2>
      </Container>
    </Layout>
  );
}

export default NotFound;
