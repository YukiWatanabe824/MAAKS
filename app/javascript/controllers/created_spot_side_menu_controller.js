import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="created-spot-side-menu"
export default class extends Controller {
  connect(){
    if (document.querySelector("#spot_menu")) {
      document.querySelector("#spot_menu").remove();
    }
  }
}
