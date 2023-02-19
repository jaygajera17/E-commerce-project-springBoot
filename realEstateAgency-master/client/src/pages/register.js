import { useState, useContext, useEffect, useRef } from "react";
import Layout from "../components/Layout";
import styled from "styled-components";
import { Button } from "../components/Button";
import { StateContext, DispatchContext } from "../context/GlobalContext";
import {
  USER_REGSITER_FAIL,
  USER_REGSITER_SUCCESS,
  USER_REGSITER_REQUEST,
} from "../context/constants/userConstants";
import axios from "axios";
import Loading from "../components/Loading";

const FormContainer = styled.div`
  margin-top: 60px;
  padding: 2rem calc((100vw - 1300px) / 2);
`;
const Alert = styled.div`
  color: red;
  margin-top: 1rem;
`;
const Form = styled.form`
  width: 40%;
  margin: 0 auto;
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  border: 1px solid #fff;
  border-radius: 10px;
  box-shadow: 0 0 4px ${({ theme }) => theme.primaryText};
  @media screen and (max-width: 768px) {
    width: 90%;
  }
  @media screen and (max-width: 48px) {
    width: 100%;
  }
`;
const InputGroup = styled.label`
  margin-top: 1rem;
`;
const Input = styled.input`
  display: block;
  width: 90%;
  /* margin-left: 1.5rem; */
  margin-bottom: 1.5rem;
  padding: 0.3rem 0.7rem;
  line-height: 1.5rem;
  border: 1px solid ${({ theme }) => theme.primaryText};
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

const ButtonContainer = styled.div`
  display: flex;
  justify-content: center;
  gap: 1rem;
`;

function Login({ history, location }) {
  const state = useContext(StateContext);
  const { user } = state;
  const dispatch = useContext(DispatchContext);
  const fromPath = useRef(location.state ? location.state.from.pathname : "/");

  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async () => {
    //form validation
    if (!name) {
      setError("Enter valid name");
      return;
    } else if (!email) {
      setError("Enter valid email");
      return;
    } else if (password !== confirmPassword) {
      setError("Passwords donot match");
      return;
    }
    //user registration
    dispatch({ type: USER_REGSITER_REQUEST });
    try {
      const { data } = await axios.post("/api/users", {
        name,
        email,
        password,
      });
      dispatch({
        type: USER_REGSITER_SUCCESS,
        payload: {},
      });
      history.push({
        pathname: "/login",
        state: { message: "Registration successful, please login to continue" },
      });
    } catch (e) {
      alert("catch");
      dispatch({ type: USER_REGSITER_FAIL, payload: e.response });
      setError(e.response?.data?.message);
    }
  };

  useEffect(() => {
    if (user && user.auth) {
      history.push(fromPath.current);
    }
  }, [history, user]);

  return (
    <Layout hideFooter="true" hideNav="false">
      {user.loading ? (
        <Loading />
      ) : (
        <FormContainer>
          <Form>
            <h2>Register</h2>
            {error && <Alert>{error}</Alert>}
            <InputGroup>
              Name:
              <Input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </InputGroup>
            <InputGroup>
              Email:
              <Input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
            </InputGroup>
            <InputGroup>
              Password:
              <Input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </InputGroup>
            <InputGroup>
              Confirm Password:
              <Input
                type="password"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
              />
            </InputGroup>
            <ButtonContainer>
              <Button onClick={handleSubmit} to="#">
                Register
              </Button>
              <Button to="#" onClick={history.goBack}>
                Cancel
              </Button>
            </ButtonContainer>
          </Form>
        </FormContainer>
      )}
    </Layout>
  );
}

export default Login;
