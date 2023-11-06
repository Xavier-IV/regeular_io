import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["notification"]
  timer = 3000

  connect() {
    setTimeout(() => {
      this.closeAll()
    }, this.timer);
  }

  closeAll() {
    this.notificationTargets.forEach((item) => {
      item.classList.add('animate-fade-out');
      setTimeout(() => {
        item.classList.add('hidden')
      }, 0)
    })
  }
}
