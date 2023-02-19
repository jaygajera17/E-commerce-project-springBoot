import { useState, useContext, useEffect } from "react";
import axios from "axios";
import { StateContext, DispatchContext } from "../context/GlobalContext";
import Layout from "../components/Layout";
import styled from "styled-components";
import GoogleApiWrapper from "../components/Map";
import ListCard from "../components/ListCard";
import Footer from "../components/Footer";
import HomeDetails from "../components/HomeDetails";
import Loading from "../components/Loading";

const Container = styled.div`
  margin-top: 60px;
  width: 100%;
  padding: 0 calc((100vw - 1300px) / 2);
  color: ${({ theme }) => theme.primaryText};
`;

const ContainerInner = styled.div`
  margin-top: 60px;
  width: 100%;
  color: ${({ theme }) => theme.primaryText};
  display: ${({ display }) => display};
  flex-wrap: wrap;
  justify-content: center;
`;

const MapWrapper = styled.div`
  flex: 1;
  max-width: 1920px;
  height: calc(100vh - 60px);
  min-height: 200px;
  position: relative;
  @media screen and (max-width: 768px) {
    /* width: 100%; */
  }
`;
const ListWrapper = styled.div`
  width: 30%;
  min-width: 400px;
  padding: 0 1.5rem;
  overflow-y: scroll;
  height: calc(100vh - 60px);
  @media screen and (max-width: 768px) {
    display: none;
  }
  &::-webkit-scrollbar-thumb {
    background: #434343;
    border-radius: 16px;
    box-shadow: inset 2px 2px 2px hsl(0deg 0% 100% / 25%),
      inset -2px -2px 2px rgb(0 0 0 / 25%);
  }
  &::-webkit-scrollbar-track {
    background: linear-gradient(90deg, #434343, #434343 1px, #111 0, #111);
  }
  &::-webkit-scrollbar {
    width: 16px;
    height: 16px;
  }
`;

const HomesPage = ({ match, history }) => {
  const state = useContext(StateContext);
  const { homes, loading, error } = state.homesList;
  const dispatch = useContext(DispatchContext);
  const [homesList, setHomesList] = useState(homes);
  const [openHomeDetails, setOpenHomeDetails] = useState(false);
  const [selectedHome, setSelectedHome] = useState(null);

  useEffect(() => {
    async function getHomes() {
      if (homesList.length === 0) {
        dispatch({ type: "HOME_LIST_REQUEST" });
        try {
          const { data } = await axios.get("/api/homes");
          setHomesList([...data]);
          dispatch({ type: "HOME_LIST_SUCCESS", payload: [...data] });
        } catch (e) {
          dispatch({ type: "HOME_LIST_FAIL", payload: "Someting went wrong" });
        }
      }
    }
    getHomes();
    console.log(homesList);
  }, [dispatch, homesList]);

  useEffect(() => {
    if (match.params.id) {
      setSelectedHome(
        homesList.filter((home) => home._id === match.params.id)[0]
      );
      setOpenHomeDetails(true);
    }
  }, [match.params.id, homesList]);
  return (
    <Layout hideFooter={true}>
      {loading ? (
        <Container>
          <Loading />
        </Container>
      ) : (
        <ContainerInner display={openHomeDetails ? "none" : "flex"}>
          {/* <MapWrapper>
            <GoogleApiWrapper />
          </MapWrapper> */}
          <ListWrapper>
            {state.map.selectedItem !== null && (
              <ListCard {...state.map.selectedItem} />
            )}
            <div
              style={{
                display: state.map.selectedItem === null ? "block" : "none",
              }}
            >
              {homesList.map((home, i) => (
                <ListCard key={i} {...home} />
              ))}
            </div>
            <Footer />
          </ListWrapper>
        </ContainerInner>
      )}

      {openHomeDetails && selectedHome && (
        <HomeDetails
          home={selectedHome}
          back={() => {
            setOpenHomeDetails(false);
            setSelectedHome(null);
            // match.params.id = undefined;
            history.goBack();
          }}
        />
      )}
    </Layout>
  );
};

export default HomesPage;
