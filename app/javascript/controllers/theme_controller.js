import { Controller } from "@hotwired/stimulus"
import { applyTheme, readStoredTheme, themeKey } from "theme"

export default class extends Controller {
  static targets = ["label", "status"]

  connect() {
    this.syncTheme(readStoredTheme())
  }

  toggle() {
    const nextTheme = document.documentElement.dataset.theme === "dark" ? "light" : "dark"

    window.localStorage.setItem(themeKey, nextTheme)
    this.syncTheme(nextTheme)
  }

  syncTheme(theme) {
    applyTheme(theme)

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