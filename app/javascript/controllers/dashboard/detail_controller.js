import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="detail--business"
export default class extends Controller {
  static targets = ['editButton']

  showEdit() {
    this.editButtonTarget.classList.remove('hidden')
  }

  hideEdit() {
    this.editButtonTarget.classList.add('hidden')
  }
}
