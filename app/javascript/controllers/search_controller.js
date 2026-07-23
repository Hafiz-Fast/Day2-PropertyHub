import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "card", "empty"]
  static values = {
    minLength: { type: Number, default: 1 },
    query: String
  }

  static classes = ["hidden"]

  connect() {
    this.filter()
  }

  filter() {
    const query = this.inputTarget.value.trim().toLowerCase()
    this.queryValue = query

    let visibleCount = 0

    this.cardTargets.forEach((card) => {
      const haystack = [card.dataset.searchTitle, card.dataset.searchLocation, card.dataset.searchOwner]
        .filter(Boolean)
        .join(" ")
        .toLowerCase()

      const showCard = query.length < this.minLengthValue || haystack.includes(query)

      card.classList.toggle(this.hiddenClass, !showCard)

      if (showCard) {
        visibleCount += 1
      }
    })

    if (this.hasEmptyTarget) {
      this.emptyTarget.hidden = visibleCount > 0
    }
  }
}