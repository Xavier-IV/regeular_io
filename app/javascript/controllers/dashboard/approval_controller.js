import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--approval"
export default class extends Controller {
  static targets = ['submitButton', 'wordCount', 'wordCountContainer', 'agreeConfirmation',
  'textArea']
  connect() {
  }

  updateWordCount(event) {
    this.wordCountTarget.textContent = 100 - event.target.value?.length

    if (event.target.value?.length >= 100) {
      this.submitButtonTarget.disabled = false
      this.submitButtonTarget.classList.remove('bg-purple-100')
      this.submitButtonTarget.classList.add('bg-purple-500')
      this.wordCountContainerTarget.classList.add('hidden')
      this.agreeConfirmationTarget.classList.remove('hidden')
      this.textAreaTarget.classList.add('border-green-500')
      this.textAreaTarget.classList.add('focus:border-green-300')
      this.textAreaTarget.classList.add('ring-green-300')
    } else {
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.classList.add('bg-purple-100')
      this.submitButtonTarget.classList.remove('bg-purple-500')
      this.wordCountContainerTarget.classList.remove('hidden')
      this.agreeConfirmationTarget.classList.add('hidden')
      this.textAreaTarget.classList.remove('border-green-500')
      this.textAreaTarget.classList.remove('focus:border-green-300')
      this.textAreaTarget.classList.remove('ring-green-300')
    }
  }
}
