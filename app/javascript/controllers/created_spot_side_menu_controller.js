import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="created-spot-side-menu"
export default class extends Controller {
  static outlets =[ "map" ]

  connect(){
    this.removeMenu()
    this.fillCoordinatesForField()
  }

  removeMenu(){
    if (document.querySelector("#spot_menu")) {
      document.querySelector("#spot_menu").remove();
    }
  }

  fillCoordinatesForField(){
    document.querySelector("#spot_longitude").value = this.mapOutlet.element.newMarker._lngLat.lng
    document.querySelector("#spot_latitude").value = this.mapOutlet.element.newMarker._lngLat.lat
  }
}
