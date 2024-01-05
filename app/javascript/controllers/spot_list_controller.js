import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["spotListContainer"];

  switchTabContent(event) {
    const activeTab = this.spotListContainerTarget.querySelector(".active-tab");
    activeTab.classList.remove("active-tab", "border-b-yellow-500", "text-base-100");
    activeTab.classList.add("border-primary", "text-primary");
    activeTab.setAttribute("data-action", "click->spot-list#switchTabContent");

    event.target.classList.remove("border-primary", "text-primary");
    event.target.classList.add("active-tab", "border-b-yellow-500", "text-base-100");
    event.target.removeAttribute("data-action");
    const indexActiveTab = Array.from(this.spotListContainerTarget.querySelectorAll(".tab")).indexOf(activeTab);
    this.spotListContainerTarget.lastChild.children[indexActiveTab].classList.add("hidden");

    const indexTargetTab = Array.from(this.spotListContainerTarget.querySelectorAll(".tab")).indexOf(event.target);
    this.spotListContainerTarget.lastChild.children[indexTargetTab].classList.remove("hidden");
  }
}
