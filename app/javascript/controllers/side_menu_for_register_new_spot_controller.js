import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static outlets = ["map"];

  connect() {
    this.removeMenu();
    this.fillCoordinatesForField();
    this.fillAddressForField();
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

  fillAddressForField(){
    document.addEventListener("turbo:before-fetch-request", async (event) => {
      event.preventDefault()
      console.log("通過チェック")

      event.detail.resume()

    })
  }
}
