import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "openButton", "closeButton"];

  connect() {
    console.log('test')
  }

  openModal() {
    console.log('opening')
    this.modalTarget.classList.remove('hidden')
  }

  closeModal() {
    this.modalTarget.classList.add('hidden')
  }
}
