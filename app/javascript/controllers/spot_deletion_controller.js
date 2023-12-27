import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["SpotDetailObject"];
  static outlets = ["map"];

  connect() {
    const spotObject = this.SpotDetailObjectTarget.dataset;
    console.log(spotObject)
    this.delete_map_pin(spotObject);
  }

  delete_map_pin(spot) {
    document.querySelector(`.spot-${spot.id}`).remove()
  }
}
