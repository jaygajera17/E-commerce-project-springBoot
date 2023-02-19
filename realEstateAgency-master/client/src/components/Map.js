import { useState, useEffect, useContext } from "react";
import { useHistory } from "react-router-dom";
import { DispatchContext, StateContext } from "../context/GlobalContext";
import { useTheme } from "styled-components";
import { mapStyles } from "../globalStyles";
import MapInfoWindow from "./MapInfoWindow";
import GoogleMapReact from "google-map-react";
import styled from "styled-components";
import { ImLocation } from "react-icons/im";


const MapMarker = styled.div`
  position: absolute;
  transform: translate(-50%, -50%);
  color: #3f51b5;

  svg {
    width: 1.5rem;
    height: 1.5rem;
    cursor: pointer;
    text-align: center;
  }
`;

const MapContainer = () => {
  const theme = useTheme();
  const history = useHistory();
  const dispatch = useContext(DispatchContext);
  const state = useContext(StateContext);
  const { homes } = state.homesList;
  const [showInfoWindow, setShowInfoWindow] = useState(false);
  const [selectedPlace, setSelectedPlace] = useState({});
  const [mapStyle, setMapStyle] = useState(mapStyles.dark);

  const location = {
    lng: -122.85,
    lat: 49.183333,
  };

   useEffect(() => {
    setMapStyle(theme.name === "dark" ? mapStyles.dark : mapStyles.light);
  }, [theme]); 



  const markerClicked = (home) => {
    setSelectedPlace(home);
    setShowInfoWindow(true);
    dispatch({ type: "SET_SELECTEDITEM", payload: home });
  };

  const closeInfoWindow = () => {
    setSelectedPlace(null);
    setShowInfoWindow(false);
    dispatch({ type: "REMOVE_SELECTEDITEM" });
  };

  const createMapOptions =()=>({
    styles: mapStyle
  })

  return (
    <div key={mapStyle} style={{ width: "100%", height: "100%" }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: process.env.REACT_APP_GOOGLE_MAP_API }}
        defaultCenter={location}
        defaultZoom={12}
        onClick={closeInfoWindow}
        options={createMapOptions}
      >
        {homes.map((home) => (
          <MapMarker
            onClick={() => markerClicked(home)}
            lat={home.position.lat}
            lng={home.position.lng}
            key={home._id}
          >
            {showInfoWindow && selectedPlace._id === home._id && (
              <MapInfoWindow
                selectedPlace={selectedPlace}
                history={history}
                closeInfoWindow={closeInfoWindow}
              />
            )}
            <ImLocation />
          </MapMarker>
        ))}
      </GoogleMapReact>
    </div>
  );
};

export default MapContainer;
