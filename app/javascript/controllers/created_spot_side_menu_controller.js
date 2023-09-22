import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="created-spot-side-menu"
export default class extends Controller {
  connect(){
    document.querySelector("#spot_menu").remove();
  }
}
