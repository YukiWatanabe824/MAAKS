import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spots-list-item"
export default class extends Controller {
  static targets = ["item"];
  static outlets = ["map"];

  jumpToSpot(){
    const lng = this.itemTarget.dataset.longitude
    const lat = this.itemTarget.dataset.latitude
    this.mapOutletElement.mapbox.flyTo({ center: [lng, lat], zoom: 15 });
  }

}
