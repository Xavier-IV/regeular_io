import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pwa"
export default class extends Controller {
  static targets = ["installButton"]

  connect() {
    window.addEventListener('beforeinstallprompt', (e) => {
      // Prevent the mini-infobar from appearing on mobile
      e.preventDefault();
      // Save the event so it can be triggered later
      this.deferredPrompt = e;
      // Make the install button visible
      this.installButtonTarget.classList.remove('hidden');
    });
  }

  async installPWA() {
    if (!this.deferredPrompt) return;

    // Show the install prompt
    this.deferredPrompt.prompt();
    // Wait for the user to respond to the prompt
    const { outcome } = await this.deferredPrompt.userChoice;

    if (outcome === 'accepted') {
      console.log('User accepted the install prompt');
    } else {
      console.log('User dismissed the install prompt');
    }

    this.deferredPrompt = null;
    this.installButtonTarget.classList.add('hidden');
  }
}
