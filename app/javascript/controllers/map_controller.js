import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

export default class extends Controller {
  static targets = ["map"];
  static outlets = ["spot"];
  static values = {
    spotid: String,
  };

  connect() {
    mapboxgl.accessToken = this.mapTarget.dataset.mapboxAccessToken;
    this.mapTarget.mapbox = new mapboxgl.Map({
      container: "map",
      style: this.mapTarget.dataset.mapboxStyle,
      center: [139.774375, 35.68442],
      zoom: 12,
    });
    this.createGeoCorder(this.mapTarget.mapbox);
    this.getSpots(this.mapTarget.mapbox);
    this.createNewSpotMarker();
  }

  zoomedMap() {
    this.mapTarget.mapbox.jumpTo({
      center: [this.mapTarget.newMarker._lngLat.lng, this.mapTarget.newMarker._lngLat.lat],
      zoom: this.mapTarget.mapbox.getZoom() + 1,
    });
    document.querySelector("#spot_menu").remove();
  }

  getSpots(map) {
    fetch("/spots.json")
      .then((response) => response.json())
      .then((spots) => {
        for (const spot of spots) {
          const el = document.createElement("div");
          el.id = spot.id;
          el.className = `spot-${spot.id} spot_marker color_palette solid_icon`;
          el.setAttribute("data-controller", "spot");
          el.setAttribute("data-spot-target", "spot");
          el.setAttribute("data-action", "click->spot#setSpotInfoForSideMenu");
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

  createNewSpotMarker() {
    this.mapTarget.mapbox.on("click", (e) => {
      if (this.mapTarget.newMarker) {
        this.mapTarget.newMarker.remove();
      }
      this.mapTarget.newMarker = new mapboxgl.Marker({
        draggable: false,
        color: "#cf5d40",
      });

      const el = this.mapTarget.newMarker.getElement();
      el.id = "new_spot_marker";
      el.setAttribute("data-controller", "spot new-spot-marker");
      el.setAttribute("data-spot-target", "spot");
      el.setAttribute("data-action", "contextmenu->spot#showSpotMenu");

      this.mapTarget.newMarker.setLngLat([e.lngLat.lng, e.lngLat.lat]).addTo(this.mapTarget.mapbox);
    });
  }

  createGeoCorder(map) {
    map.addControl(
      // eslint-disable-next-line
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
      })
    );
  }
}
