import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

import mapboxgl from "mapbox-gl"; // or "const mapboxgl = require('mapbox-gl');"

mapboxgl.accessToken =
  "pk.eyJ1IjoieXVraXdhdGFuYWJlIiwiYSI6ImNsamx3NmQ2NzEwZTczZXBwOTUzbDE5amsifQ.ep62YrWWsdT4HtVFLVA-Og";

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

    // マップを表示
    const map = new mapboxgl.Map({
      container: "map", // container ID
      style: "mapbox://styles/yukiwatanabe/cljqcpwss004501oc6qhs4rek", // style URL
      center: feature.center, // starting position [lng, lat]
      zoom: 14, // starting zoom
    });

    // create geocoder
    map.addControl(
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
      })
    );

    // create the popup
    const popup = new mapboxgl.Popup({ offset: 25 }).setText(
      "ここが越谷レイクタウン"
    );

    // create DOM element for the marker
    const el = document.createElement("div");
    el.id = "marker";

    // create the marker with popup
    new mapboxgl.Marker()
      .setLngLat(feature.center)
      .setPopup(popup)
      .addTo(map);
  });
