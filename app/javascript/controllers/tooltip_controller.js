import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
    tippy('.on-review', {
      content: 'This is your submission. We will review shortly.',
      hideOnClick: false,
    });
  }
}
