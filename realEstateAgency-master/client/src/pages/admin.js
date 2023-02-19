import { useContext, useEffect, useState } from "react";
import Layout from "../components/Layout";
import styled from "styled-components";
import HomeList from "../adminScreens/HomeList";
import HomeGrid from "../adminScreens/HomeGrid";
import { StateContext, DispatchContext } from "../context/GlobalContext";
import axios from "axios";
import HomeDetails from "../components/HomeDetails";
import { GoDashboard } from "react-icons/go";
import { FaListUl } from "react-icons/fa";
import { BsGrid } from "react-icons/bs";
import SubNavigation, { SubNavItem } from "../components/SubNavigation";

const Container = styled.div`
  height: 100%;
  padding: 0 calc((100vw - 1300px) / 2);
  padding-top: 60px;
`;

const MainContent = styled.div`
  flex: 1;
`;

function Admin() {
  const state = useContext(StateContext);
  const dispatch = useContext(DispatchContext);
  const { userHomes, loading, error } = state.homesList;
  const [homesList, setHomesList] = useState(userHomes);
  const [selectedHome, setSelectedHome] = useState(null);

  const [openedTab, setOpnedTab] = useState(null);
  useEffect(() => {
    async function getHomes() {
      if (homesList.length === 0) {
        dispatch({ type: "HOME_LIST_USER_REQUEST" });
        try {
          const config = {
            headers: {
              "Content-Type": "multipart/form-data",
              Authorization: `Bearer ${localStorage.userToken}`,
            },
          };
          const { data } = await axios.get("/api/homes/user",config);
          setHomesList([...data]);
          dispatch({ type: "HOME_LIST_USER_SUCCESS", payload: [...data] });
        } catch (e) {
          dispatch({ type: "HOME_LIST_USER_FAIL", payload: "Someting went wrong" });
        }
      }
    }
    getHomes();
  }, [dispatch, homesList]);

  const deleteHome =async (home)=>{
    if(window.confirm(`Are you sure you want to delete ${home.address}?`)){
      dispatch({ type: "HOME_DELETE_REQUEST" });
        try {
          const config = {
            headers: {
              "Content-Type": "multipart/form-data",
              Authorization: `Bearer ${localStorage.userToken}`,
            },
          };
          await axios.delete(`/api/homes/${home._id}`,config);
          dispatch({ type: "HOME_DELETE_SUCCESS", payload: home });
        } catch (e) {
          dispatch({ type: "HOME_DELETE_FAIL", payload: "Someting went wrong" });
        }
    }
  }

  return (
    <Layout>
      {!selectedHome ? (
        <Container>
          <SubNavigation>
            <SubNavItem
              className={
                openedTab === null || openedTab === "dashboard"
                  ? "selected"
                  : ""
              }
              onClick={() => setOpnedTab(null)}
            >
              <GoDashboard />
              <span>Dashboard</span>
            </SubNavItem>
            <SubNavItem
              className={openedTab === "propertyList" ? "selected" : ""}
              onClick={() => setOpnedTab("propertyList")}
            >
              <FaListUl />
              <span>Property List</span>
            </SubNavItem>
            <SubNavItem
              className={openedTab === "propertyGrid" ? "selected" : ""}
              onClick={() => setOpnedTab("propertyGrid")}
            >
              <BsGrid />
              <span>Property Grid</span>
            </SubNavItem>
          </SubNavigation>
          <MainContent>
            {(openedTab === "dashboard" || openedTab === null) && (
              <div style={{ textAlign: "center" }}>In Development</div>
            )}
            {openedTab === "propertyList" && (
              <HomeList
                homesList={homesList}
                setSelectedHome={setSelectedHome}
                deleteHome={deleteHome}
              />
            )}
            {openedTab === "propertyGrid" && (
              <HomeGrid
                homesList={homesList}
                setSelectedHome={setSelectedHome}
                deleteHome={deleteHome}
              />
            )}
          </MainContent>
        </Container>
      ) : (
        <HomeDetails home={selectedHome} back={() => setSelectedHome(null)} />
      )}
    </Layout>
  );
}

export default Admin;
