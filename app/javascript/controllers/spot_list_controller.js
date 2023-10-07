import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="spot-list"
export default class extends Controller {
  static targets = ["spotListContainer"];

  switchTabContent(event) {
    const activeTab = this.spotListContainerTarget.querySelector(".tab-active");
    activeTab.classList.remove("tab-active", "bg-base-100");
    activeTab.classList.add("bg-accent");
    activeTab.setAttribute("data-action", "click->spot-list#switchTabContent");

    event.target.classList.add("tab-active", "bg-base-100");
    event.target.removeAttribute("data-action");
    const indexActiveTab = Array.from(
      this.spotListContainerTarget.querySelectorAll(".tab")
    ).indexOf(activeTab);
    this.spotListContainerTarget.lastChild.children[
      indexActiveTab
    ].classList.add("hidden");

    const indexTargetTab = Array.from(
      this.spotListContainerTarget.querySelectorAll(".tab")
    ).indexOf(event.target);
    this.spotListContainerTarget.lastChild.children[
      indexTargetTab
    ].classList.remove("hidden");
  }
}
