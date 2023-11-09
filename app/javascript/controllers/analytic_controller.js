import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="analytic"
export default class extends Controller {
  track({ params }) {
    if (!params.key) return
    amplitude.track(params.key)
  }
}
