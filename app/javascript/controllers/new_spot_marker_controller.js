import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const url = "spots/new";
    Turbo.visit(url, { frame: "side_menu" }); //eslint-disable-line
  }
}
