import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "openButton", "closeButton"];
  static outlets = [ "master" ]

  openModal() {
    this.modalTarget.classList.remove('hidden')
    this.masterOutletElement.classList.add('overflow-hidden')
    amplitude.track('modal.open');
  }

  closeModal() {
    this.modalTarget.classList.add('hidden')
    this.masterOutletElement.classList.remove('overflow-hidden')
    amplitude.track('modal.close');
  }
}
