import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--profile-tray"
export default class extends Controller {
  static targets = ['menu']

  menuOpened = false

  toggle() {
    this.menuOpened = !this.menuOpened;

    if (!this.menuOpened) {
      this.menuTarget.classList.add('hidden')
    } else {
      this.menuTarget.classList.remove('hidden')
    }
  }

  screenToggle(event) {
    if (this.menuOpened && !['profile_avatar', 'profile_avatar_filled'].includes(event.target.id)) {
      this.menuOpened = !this.menuOpened;
      this.menuTarget.classList.add('hidden')
    }
  }
}
