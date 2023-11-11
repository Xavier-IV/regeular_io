import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--survey"
export default class extends Controller {
  static targets = ['surveyAction', 'surveyContainer', 'surveyMessage']
  static values = {
    key: String
  }
  connect() {
    this.initState()
  }

  toggle({ params }) {
    this.initState(params.value)
  }

  initState(enabled){
    let value = localStorage.getItem(`public.${this.keyValue}`)

    if (enabled != null) {
      value = String(enabled)
    }

    if (value !== 'true') {
      this.surveyContainerTarget.classList.remove('hidden')
    } else {
      this.surveyMessageTarget.textContent = 'Thank you for your answer!'
      this.surveyActionTarget.classList.add('hidden')
    }
  }
}
