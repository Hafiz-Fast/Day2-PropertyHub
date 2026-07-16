import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello Controller Connected!")
  }

  greet() {
    alert("Welcome to PropertyHub!")
  }
}