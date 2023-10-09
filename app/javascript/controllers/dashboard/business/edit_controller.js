import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--business--edit"
export default class extends Controller {
  static targets = ['formBox', 'businessIdLabel']

  inputChange(event) {
    if (event.target.value.length > 0) {
      this.businessIdLabelTarget.classList.remove('md:invisible')
      return
    }
    this.businessIdLabelTarget.classList.add('md:invisible')
  }
}
