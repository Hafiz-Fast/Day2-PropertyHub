import { Controller } from "@hotwired/stimulus"
import { applyTheme, readStoredTheme, themeKey } from "theme"

export default class extends Controller {
  static targets = ["label", "status"]
  static values = {
    mode: { type: String, default: "light" },
    showBadge: { type: Boolean, default: false }
  }

  static classes = ["active", "inactive"]

  connect() {
    this.syncTheme(readStoredTheme())
  }

  toggle() {
    const nextTheme = this.modeValue === "dark" ? "light" : "dark"

    window.localStorage.setItem(themeKey, nextTheme)
    this.modeValue = nextTheme
    this.syncTheme(nextTheme)
  }

  syncTheme(theme) {
    applyTheme(theme)

    this.modeValue = theme
    this.showBadgeValue = theme === "dark"

    this.element.classList.toggle(this.activeClass, theme === "dark")
    this.element.classList.toggle(this.inactiveClass, theme === "light")

    if (this.hasLabelTarget) {
      this.labelTarget.textContent = theme === "dark" ? "Light mode" : "Dark mode"
    }

    if (this.hasStatusTarget) {
      this.statusTarget.textContent = theme === "dark" ? "Dark" : "Light"
    }

    this.element.setAttribute("aria-label", theme === "dark" ? "Switch to light mode" : "Switch to dark mode")
    this.element.setAttribute("aria-pressed", String(theme === "dark"))
  }
}