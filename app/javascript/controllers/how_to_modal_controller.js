import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["HowToModal"];

  connect() {
    document.querySelector("#how_to_modal_button").click();
  }
}
