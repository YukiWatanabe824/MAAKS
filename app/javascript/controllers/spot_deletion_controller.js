import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    id: String,
  };

  connect() {
    this.deleteMapPin(this.idValue);
  }

  deleteMapPin(spotId) {
    document.getElementById(spotId).remove();
  }
}
