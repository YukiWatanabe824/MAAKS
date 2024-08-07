import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static outlets = ["map"];

  connect() {
    this.removeMenu();
    this.fillCoordinatesForField();
  }

  slideOut() {
    document.querySelector(".aside_for_reg").classList.remove("display");
  }

  removeMenu() {
    if (document.querySelector("#spot_menu")) {
      document.querySelector("#spot_menu").remove();
    }
  }

  fillCoordinatesForField() {
    document.querySelector("#spot_longitude").value = this.mapOutlet.element.newMarker._lngLat.lng;
    document.querySelector("#spot_latitude").value = this.mapOutlet.element.newMarker._lngLat.lat;
  }
}
