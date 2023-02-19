import { useState, useEffect } from "react";
import PlacesAutocomplete, {
  geocodeByAddress,
  getLatLng,
} from "react-places-autocomplete";
import styled, { css } from "styled-components";

const InputDiv = styled.div`
  position: relative;
  margin-bottom: 1.5rem;
`;
const inputCss = css`
  width: 100%;
  margin-left: 1.5rem;

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

const AutoCompleteDiv = styled.div`
  width: 100%;
  margin-left: 1.5rem;
  line-height: 1.5rem;
  border: ${({ border }) => border};
  border-radius: 0.25rem;
  background: ${({ theme }) => theme.background};
  max-height: 120px;
  overflow-y: auto;
  position: absolute;
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

const AutoCompleteItem = styled.div`
  cursor: pointer;
  margin: 0.2rem 0;
  padding: 0.3rem 0.7rem;
  color: ${({ theme }) => theme.secondaryText};
  &:hover {
    color: ${({ theme }) => theme.primaryText};
    background: ${({ theme }) => theme.backgroundVariant};
  }
`;

const loadMapScript = (callback) => {
  const existingScript = document.getElementById("googleMaps");
  if (!existingScript) {
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.REACT_APP_GOOGLE_MAP_API}&libraries=places`;
    script.id = "googleMaps";
    document.body.appendChild(script);
    script.onload = () => {
      if (callback) callback();
    };
  }
  if (existingScript && callback) callback();
};

function AutoCompleteAddress({ setAddress: setMainAddress }) {
  const [scriptLoaded, setScriptLoaded] = useState(false);
  const [address, setAddress] = useState("");
  const handleChange = (address) => setAddress(address);
  const handleSelect = async (address) => {
    try {
      const results = await geocodeByAddress(address);
      var position = await getLatLng(results[0]);
      setAddress(address);
      let { address_components } = results[0];
      let city = address_components.filter((comp) =>
        comp.types.includes("locality")
      )[0];
      let state = address_components.filter((comp) =>
        comp.types.includes("administrative_area_level_1")
      )[0];
      let country = address_components.filter((comp) =>
        comp.types.includes("country")
      )[0];
      let postalCode = address_components.filter((comp) =>
        comp.types.includes("postal_code")
      )[0];
      setMainAddress({
        address: address.split(",")[0],
        city: city.short_name,
        state: state.short_name,
        postalCode: postalCode.short_name,
        country: country.short_name,
        position,
      });
    } catch (e) {
      console.log(e);
    }
  };
  useEffect(() => {
    loadMapScript(() => setScriptLoaded(true));
  }, []);
  return (
    scriptLoaded && (
      <PlacesAutocomplete
        value={address}
        onChange={handleChange}
        onSelect={handleSelect}
      >
        {({ getInputProps, suggestions, getSuggestionItemProps, loading }) => (
          <InputDiv>
            <Input
              {...getInputProps({
                placeholder: "*Property Address...",
                className: "location-search-input",
              })}
            />
            <AutoCompleteDiv
              border={suggestions.length > 0 ? "1px solid #ced4da" : "none"}
            >
              {loading && <AutoCompleteItem>Loading...</AutoCompleteItem>}
              {suggestions.map((suggestion, i) => {
                return (
                  <AutoCompleteItem
                    key={i}
                    {...getSuggestionItemProps(suggestion)}
                  >
                    <span>{suggestion.description}</span>
                  </AutoCompleteItem>
                );
              })}
            </AutoCompleteDiv>
          </InputDiv>
        )}
      </PlacesAutocomplete>
    )
  );
}

export default AutoCompleteAddress;
