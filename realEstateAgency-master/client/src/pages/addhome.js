import { useEffect, useState } from "react";
import styled, { css } from "styled-components";
import AutoCompleteAddress from "../components/AutoCompleteAddress";
import Layout from "../components/Layout";
import axios from "axios";
import Loading from "../components/Loading";

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

const Error = styled.div`
  ${inputCss}
  color: red;
  border-color: red;
  margin-bottom: 1rem;
`;

const Message = styled.div`
  ${inputCss}
  color: green;
  border-color: green;
  margin-bottom: 1rem;
`;

function Addhome() {
  // const [address, setAddress] = useState({
  //   state: "",
  //   city: "",
  //   address: "",
  //   postalCode: "",
  //   country: "",

  //   position: { lat: 38.8951, lng: -77.0364 },
  // });

   const [state, setstate] = useState("");
    const [city, setcity] = useState("");
    const [address, setaddress] = useState("");
    const [postalCode, setpostalCode] = useState("");
    const [country, setcountry] = useState("");
  // const [images, setImages] = useState([]);
  const [files, setFiles] = useState("");
  const [loading, setLoading] = useState(false);
  const [price, setPrice] = useState("");
  const [type, setType] = useState("");
  const [rooms, setRooms] = useState("");
  const [washrooms, setWashrooms] = useState("");
  const [size, setSize] = useState("");
  const [details, setDetails] = useState("");

  const [error, setError] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = async (e) => {
    console.log("In submit");
    e.preventDefault();
    if (!validateForm()) {
      setError("Please fill all inputs with * and try again");
      return;
    }
    var imgArrary = await uploadFileHandler();
    console.log(imgArrary);
    setLoading(true);
    try {
      const config = {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.userToken}`,
        },
      };
      await axios.post(
        "/api/homes",
        {
          address,
          city,
          state,
          postalCode,
          country,
          // position: address.position,
          images: imgArrary,
          price,
          type,
          rooms,
          washrooms,
          size,
          details,
        },
        config
      );
      setMessage("Property added!");
      setError("");
      //resetting form
      // setAddress({
      //   address: "",
      //   position: { lat: "", lng: "" },
      // });
      // setImages([]);
      setFiles("");
      setPrice("");
      setType("");
      setRooms("");
      setWashrooms("");
      setSize("");
      setDetails("");
    } catch (e) {
      // dispatch({ type: USER_LOGIN_FAIL, payload: e });
      console.log(e);
      setError(
        e.response.data.message
          ? e.response.data.message
          : "Something went wrong please check all inputs and try again"
      );
    }
    setLoading(false);
  };

  const uploadFileHandler = async (e) => {
    const formData = new FormData();
    for (const [key, value] of Object.entries(files)) {
      formData.append("image", value);
    }
    setLoading(true);
    try {
      const config = {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${localStorage.userToken}`,
        },
      };
      const { data } = await axios.post("/api/upload", formData, config);
      // setImages([...data]);
      setLoading(false);
      return data;
    } catch (error) {
      setLoading(false);
      setError("Error in uploading images");
    }
  };

  const validateForm = () => {
    console.log(address + files + price + type + rooms + washrooms + size);
    // if (!address.address || !files || !price || !type || !details) return false;
    return true;
  };

  return (
    <Layout>
      {loading && <Loading />}
      <Container>
        <FormContainer>
          <h1>Add new Property</h1>
          {error && <Error>{error}</Error>}
          {message && <Message>{message}</Message>}
          {/* <AutoCompleteAddress setAddress={setAddress} /> */}
          <Input
            placeholder="*Address"
            value={address}
            onChange={(e) => setaddress(e.target.value)}
            required
          />
          <Input
            placeholder="*City"
            value={city}
            onChange={(e) => setcity(e.target.value)}
            required
          />
          <Input
            placeholder="* State"
            value={state}
            onChange={(e) => setstate(e.target.value)}
            required
          />
          <Input
            placeholder="* PostalCode"
            value={postalCode}
            onChange={(e) => setpostalCode(e.target.value)}
            required
          />
          <Input
            placeholder="* Country"
            value={country}
            onChange={(e) => setcountry(e.target.value)}
            required
          />
          <Input
            placeholder="*Property type"
            value={type}
            onChange={(e) => setType(e.target.value)}
            required
          />
          <Input
            placeholder="*Price"
            value={price}
            onChange={(e) => setPrice(e.target.value)}
            required
          />
          <Input
            placeholder="Number of rooms"
            value={rooms}
            onChange={(e) => setRooms(e.target.value)}
          />
          <Input
            placeholder="Number of Washrooms"
            value={washrooms}
            onChange={(e) => setWashrooms(e.target.value)}
          />
          <Input
            placeholder="Size of the Property (FT²)"
            value={size}
            onChange={(e) => setSize(e.target.value)}
          />
          <TextArea
            placeholder="*Property details"
            value={details}
            onChange={(e) => setDetails(e.target.value)}
            required
          />
          <Input
            type="file"
            multiple
            onChange={(e) => setFiles(e.target.files)}
          />
          <Button onClick={handleSubmit} to="#">
            Submit
          </Button>
        </FormContainer>
      </Container>
    </Layout>
  );
}

export default Addhome;
