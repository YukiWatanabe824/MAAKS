import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["map"];
  static outlets = ["spot"];
  static values = {
    spotid: String,
  };

  connect() {
    mapboxgl.accessToken =
      "pk.eyJ1IjoieXVraXdhdGFuYWJlIiwiYSI6ImNsamx3NmQ2NzEwZTczZXBwOTUzbDE5amsifQ.ep62YrWWsdT4HtVFLVA-Og";
    // マップを表示
    this.mapTarget.mapbox = new mapboxgl.Map({
      container: "map", // container ID
      style: "mapbox://styles/yukiwatanabe/cljqcpwss004501oc6qhs4rek", // style URL
      center: [139.791003, 35.777343], // starting position [lng, lat]
      zoom: 12, // starting zoom
    });
    this.createGeoCorder(this.mapTarget.mapbox);
    this.getSpots(this.mapTarget.mapbox);
    this.createMarker();
  }

  zoomedMap() {
    this.mapTarget.mapbox.jumpTo({
      center: [
        this.mapTarget.newMarker._lngLat.lng,
        this.mapTarget.newMarker._lngLat.lat,
      ],
      zoom: this.mapTarget.mapbox.getZoom() + 1,
    });
    document.querySelector("#spot_menu").remove();
  }

  getSpots(map) {
    fetch("/spots.json")
      .then((response) => response.json())
      .then((spots) => {
        // DBから取得したスポットの描画
        for (const spot of spots) {
          // create DOM element for the marker
          const el = document.createElement("div");
          el.id = spot.id;
          el.className = "spot_marker color_palette solid_icon";
          el.setAttribute("data-controller", "spot");
          el.setAttribute("data-spot-target", "spot");
          el.setAttribute("data-action", "click->spot#setSpotInfo");
          // create the marker with popup
          new mapboxgl.Marker({
            element: el,
          })
            .setLngLat([spot.longitude, spot.latitude])
            .addTo(map);
        }
      });
  }

  deleteSpotMenu(event) {
    if (event.target === document.querySelector(".mapboxgl-canvas")) {
      if (document.querySelector("#spot_menu")) {
        document.querySelector("#spot_menu").remove();
      }
    } else {
      return;
    }
  }

  getCoordinates() {
    if (document.querySelector(`#spot_menu`)) {
      return;
    } else {
      this.createMarker();
    }
  }

  createMarker() {
    this.mapTarget.mapbox.on("click", (e) => {
      if (this.mapTarget.newMarker) {
        this.mapTarget.newMarker.remove();
      }
      this.mapTarget.newMarker = new mapboxgl.Marker({
        draggable: true,
        color: "#cf5d40",
      });

      const el = this.mapTarget.newMarker.getElement();
      el.id = "new_spot_marker";
      el.setAttribute("data-controller", "spot");
      el.setAttribute("data-spot-target", "spot");
      el.setAttribute("data-action", "contextmenu->spot#showSpotMenu");

      this.mapTarget.newMarker
        .setLngLat([e.lngLat.lng, e.lngLat.lat])
        .addTo(this.mapTarget.mapbox);
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
}
