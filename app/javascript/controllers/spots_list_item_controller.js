import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"];
  static outlets = ["map"];

  jumpToSpot(){
    const lng = this.itemTarget.dataset.longitude
    const lat = this.itemTarget.dataset.latitude
    this.mapOutletElement.mapbox.flyTo({ center: [lng, lat], zoom: 15 });
  }

}
