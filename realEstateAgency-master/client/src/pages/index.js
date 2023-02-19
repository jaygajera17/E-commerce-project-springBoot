import Hero from "../components/Hero";
import Layout from "../components/Layout";
import InfoSection from "../components/InfoSection";
import { SliderData } from "../data/SliderData";
import { InfoData, InfoDataTwo } from "../data/InfoData";
import CardSection from "../components/CardSection";
import {homes} from '../data/homesData'

function index() {
  return (
    <Layout atHome>
      <Hero slides={SliderData} />
      <InfoSection {...InfoData} />
      <InfoSection {...InfoDataTwo} />
      <CardSection itemOne={homes[0]} itemTwo={homes[1]} header="Featured" />
    </Layout>
  );
}

export default index;
