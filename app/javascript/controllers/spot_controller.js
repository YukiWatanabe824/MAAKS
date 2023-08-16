import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="spot"
export default class extends Controller {
  static targets = [ "spot" ];

  setSpotInfo(){
    const url = `spots/${this.spotTarget.id}`
    Turbo.visit(url, { frame: 'drawer_menu' })
  }

  showSpotMenu(e) {
    if (this.spotTarget.id == "new_spot_marker"){
      this.spotTarget.menu = document.createElement("div");
      const menu = this.spotTarget.menu;
      menu.id = `spot_menu`;
      menu.className = `${this.spotTarget.id} menu bg-base-200 w-56 rounded-box`;
      menu.innerHTML = `<ul>
        <li><a data-action="click->map#zoomedMap" >ズームする</a></li>
        <li><a data-turbo-frame="drawer_menu" href="/spots/new" data-action="click->map#showDrawer" >スポットを作成する</a>
        </ul>`;

      menu.style.left = e.pageX + "px";
      menu.style.top = e.pageY + "px";

      const map = document.querySelector("#map");
      map.appendChild(menu);
    }
  }
}