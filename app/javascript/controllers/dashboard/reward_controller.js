import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--reward"
export default class extends Controller {
  static targets = ["value", "valueType", "cappedAmount", "capPreview", "capForm", "suffix", "prefix", "output"]

  handleChange(event) {
    this.outputTarget.textContent = this.valueTarget.value
  }

  handleCappedAmount(event) {
    if (event.target.value == '') {
      return this.capPreviewTarget.textContent = 'Missing capped amount'
    }
    this.cappedAmountTarget.textContent = event.target.value
  }

  handleValueType(event) {
    const prefix = event.target.value == 'fixed' ? 'RM' : ''
    const suffix = event.target.value == 'percentage' ? '%' : ''

    if (event.target.value == 'fixed') {
      this.capPreviewTarget.classList.add('hidden')
      this.capFormTarget.classList.add('hidden')
    } else {
      this.capPreviewTarget.classList.remove('hidden')
      this.capFormTarget.classList.remove('hidden')
    }

    this.suffixTarget.textContent = suffix
    this.prefixTarget.textContent = prefix
    this.outputTarget.textContent = this.valueTarget.value
  }

  updateOutput(event) {
  }
}
