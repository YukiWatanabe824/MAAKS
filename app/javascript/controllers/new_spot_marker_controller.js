import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const url = "spots/new";
    Turbo.visit(url, { frame: "spot_regist_window" }); //eslint-disable-line
    this.displayForRegWindow();
  }

  displayForRegWindow() {
    const el = document.querySelector(".aside_for_reg");
    el.classList.add("display");
  }
}
