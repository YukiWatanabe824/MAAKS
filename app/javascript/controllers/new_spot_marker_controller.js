import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.querySelector('#new_spot_marker').addEventListener("pointerdown", () => {
      const intervalId = setInterval(changeMenu, 300);

      document.addEventListener(
        "pointerup", () => {
          clearInterval(intervalId);
        }, { once: true }
      );
    });

    const changeMenu = () => {
      const url = 'spots/new'
      Turbo.visit(url, { frame: 'side_menu' })
    }
  }
}
