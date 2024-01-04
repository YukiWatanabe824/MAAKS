import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    id: String,
  };

  connect() {
    this.delete_map_pin(this.idValue);
  }

  delete_map_pin(spotId) {
    document.getElementById(spotId).remove();
  }
}
