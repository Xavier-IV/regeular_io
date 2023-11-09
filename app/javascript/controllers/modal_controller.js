import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "openButton", "closeButton"];

  openModal() {
    this.modalTarget.classList.remove('hidden')
    amplitude.track('modal.open');
  }

  closeModal() {
    this.modalTarget.classList.add('hidden')
    amplitude.track('modal.close');
  }
}
