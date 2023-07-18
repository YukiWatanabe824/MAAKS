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

fetch("/spots.json")
  .then((response) => response.json())
  .then((spot) => {
    // データの取得後の処理
    console.log(spot);

    // マップを表示
    const map = new mapboxgl.Map({
      container: "map", // container ID
      style: "mapbox://styles/yukiwatanabe/cljqcpwss004501oc6qhs4rek", // style URL
      center: [spot[0].longitude, spot[0].latitude], // starting position [lng, lat]
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
    const popup = new mapboxgl.Popup({ offset: 25 }).setHTML(
      `<div><h2>${spot[0].title}</h2><ul><li>${spot[0].accident_date}</li><li>${spot[0].accident_type}</li><li>${spot[0].contents}</li></ul></div>`
    );

    // create DOM element for the marker
    const el = document.createElement("div");
    el.id = "marker";

    // create the marker with popup
    new mapboxgl.Marker()
      .setLngLat([spot[0].longitude, spot[0].latitude])
      .setPopup(popup)
      .addTo(map);
  })
  .catch((error) => {
    // エラーハンドリング
    console.error(error);
  });
