import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="spot"
export default class extends Controller {
  static targets = ["spot"];

  showSpotMenu(e) {
    console.log(this.spotTarget.id);

    // メニュー定義
    this.spotTarget.menu = document.createElement("div");
    const menu = this.spotTarget.menu;
    menu.id = `spot_menu`;
    menu.className = `${this.spotTarget.id} menu bg-base-200 w-56 rounded-box`;
    menu.innerHTML = `<ul>
      <li><a data-action="click->map#zoomedMap" >ズームする</a></li>
      <li><a data-action="click->map#showDrawer" >スポットを作成する</a>
      </ul>`;

    menu.style.left = e.pageX + "px";
    menu.style.top = e.pageY + "px";

    if (document.querySelector(`.${this.spotTarget.id}`)){
    } else {
      const map = document.querySelector("#map");
      map.appendChild(menu);
    }
  }
}
