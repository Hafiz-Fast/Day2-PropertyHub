import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "details", "label"]

  connect() {
    this.collapse()
  }

  toggle() {
    if (this.detailsTarget.hidden) {
      this.expand()
      return
    }

    this.collapse()
  }

  expand() {
    this.detailsTarget.hidden = false

    if (this.hasLabelTarget) {
      this.labelTarget.textContent = "Hide details"
    }

    this.buttonTarget.setAttribute("aria-expanded", "true")
  }

  collapse() {
    this.detailsTarget.hidden = true

    if (this.hasLabelTarget) {
      this.labelTarget.textContent = "View details"
    }

    this.buttonTarget.setAttribute("aria-expanded", "false")
  }
}