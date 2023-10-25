import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

export default class extends Controller {
  static targets = ["SpotDetailPanel"];
  static outlets = ["map"];

  connect() {
    const spotObject = this.SpotDetailPanelTarget.dataset;
    this.addSpot(spotObject);
  }

  addSpot(spot) {
    const el = document.createElement("div");
    el.id = spot.id;
    el.className = `spot-${spot.id} spot_marker color_palette solid_icon`;
    el.setAttribute("data-controller", "spot");
    el.setAttribute("data-spot-target", "spot");
    el.setAttribute("data-action", "click->spot#setSpotInfoForSideMenu");

    mapboxgl.accessToken = this.mapOutlet.mapTarget.dataset.mapboxAccessToken;

    new mapboxgl.Marker({
      element: el,
    })
      .setLngLat([spot.longitude, spot.latitude])
      .addTo(this.mapOutlet.element.mapbox);
  }
}
