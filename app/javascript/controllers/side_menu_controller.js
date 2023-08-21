import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="side-menu"
export default class extends Controller {
  static outlets =[ "map" ]

  setCoordinate(){
    document.querySelector("#spot_longitude").value = this.mapOutlet.element.newMarker._lngLat.lng
    document.querySelector("#spot_latitude").value = this.mapOutlet.element.newMarker._lngLat.lat
  }

}
