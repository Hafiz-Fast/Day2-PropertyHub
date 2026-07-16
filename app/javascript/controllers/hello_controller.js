import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    console.log("Hello Controller Connected!")
  }

  // greet(event) {
  //   console.log(event)
  //   alert("Welcome to PropertyHub!")
  // }

  greet(){
    this.messageTarget.textContent = "Welcome to PropertyHub!"
  }
}