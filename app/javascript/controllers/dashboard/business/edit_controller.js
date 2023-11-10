import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--business--edit"
export default class extends Controller {
  static targets = ['formBox']

  inputChange(event) {
  }
}
