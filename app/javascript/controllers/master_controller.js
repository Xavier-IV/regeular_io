import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="master"
export default class extends Controller {
  connect() {
    console.log('connected!')
  }
}
