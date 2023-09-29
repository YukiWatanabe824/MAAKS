import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="showing-spot-menu"
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
    el.className = "spot_marker color_palette solid_icon";
    el.setAttribute("data-controller", "spot");
    el.setAttribute("data-spot-target", "spot");
    el.setAttribute("data-action", "click->spot#setSpotInfo");

    mapboxgl.accessToken =
      "pk.eyJ1IjoieXVraXdhdGFuYWJlIiwiYSI6ImNsamx3NmQ2NzEwZTczZXBwOTUzbDE5amsifQ.ep62YrWWsdT4HtVFLVA-Og";

    new mapboxgl.Marker({
      element: el,
    })
      .setLngLat([spot.longitude, spot.latitude])
      .addTo(this.mapOutlet.element.mapbox);
  }
}