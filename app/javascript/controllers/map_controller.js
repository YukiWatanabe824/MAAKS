import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["map"];

  connect() {
    mapboxgl.accessToken =
      "pk.eyJ1IjoieXVraXdhdGFuYWJlIiwiYSI6ImNsamx3NmQ2NzEwZTczZXBwOTUzbDE5amsifQ.ep62YrWWsdT4HtVFLVA-Og";
    // マップを表示
    const map = new mapboxgl.Map({
      container: "map", // container ID
      style: "mapbox://styles/yukiwatanabe/cljqcpwss004501oc6qhs4rek", // style URL
      center: [139.791003, 35.777343], // starting position [lng, lat]
      zoom: 12, // starting zoom
    });
    this.createGeoCorder(map);
    this.getSpots(map)
  }

  getSpots(map) {
    fetch("/spots.json")
      .then((response) => response.json())
      .then((spots) => {
        // DBから取得したスポットの描画
        for (const spot of spots) {
          // create the popup
          const popup = new mapboxgl.Popup({ offset: 25 }).setHTML(
            `<div><h2>${spot.title}</h2><ul><li>${spot.accident_date}</li><li>${spot.accident_type}</li><li>${spot.contents}</li></ul></div>`
          );
          // create DOM element for the marker
          const el = document.createElement("div");
          el.id = "marker";
          el.class = "spot_marker"
          // create the marker with popup
          new mapboxgl.Marker()
            .setLngLat([spot.longitude, spot.latitude])
            .setPopup(popup)
            .addTo(map);
        }
      });
    }

  createGeoCorder(map) {
    map.addControl(
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
      })
    );
  }

  //     let newMarker = "";
  //     map.on("click", (e) => {
  //       console.log(`座標は ${e.lngLat}`);
  //       if (newMarker) {
  //         newMarker.remove();
  //         newMarker = new mapboxgl.Marker()
  //           .setLngLat([e.lngLat.lng, e.lngLat.lat])
  //           .addTo(map);
  //       } else {
  //         newMarker = new mapboxgl.Marker()
  //           .setLngLat([e.lngLat.lng, e.lngLat.lat])
  //           .addTo(map);
  //       }
  //       let formLatitude = document.querySelector("#latitude");
  //       formLatitude.value = e.lngLat.lat;
  //       let formLongitude = document.querySelector("#longitude");
  //       formLongitude.value = e.lngLat.lng;
  //     });
  //   })
  //   .catch((error) => {
  //     // エラーハンドリング
  //     console.error(error);
  //   });
}
