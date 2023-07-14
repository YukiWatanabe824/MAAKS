import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

import mapboxgl from "mapbox-gl"; // or "const mapboxgl = require('mapbox-gl');"

mapboxgl.accessToken =
  "pk.eyJ1IjoieXVraXdhdGFuYWJlIiwiYSI6ImNsamx3NmQ2NzEwZTczZXBwOTUzbDE5amsifQ.ep62YrWWsdT4HtVFLVA-Og";
const map = new mapboxgl.Map({
  container: "map", // container ID
  style: "mapbox://styles/yukiwatanabe/cljqcpwss004501oc6qhs4rek", // style URL
  center: [139.81010425, 35.71001875], // starting position [lng, lat]
  zoom: 9, // starting zoom
});

const mapboxClient = mapboxSdk({ accessToken: mapboxgl.accessToken });
mapboxClient.geocoding
  .forwardGeocode({
    query: "越谷レイクタウン",
    autocomplete: false,
    limit: 1,
  })
  .send()
  .then((response) => {
    if (
      !response ||
      !response.body ||
      !response.body.features ||
      !response.body.features.length
    ) {
      console.error("Invalid response:");
      console.error(response);
      return;
    }

    const feature = response.body.features[0];

    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v11",
      center: feature.center,
      zoom: 10,
    });

    new mapboxgl.Marker().setLngLat(feature.center).addTo(map);
  });

map.addControl(
  new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl,
  })
);
