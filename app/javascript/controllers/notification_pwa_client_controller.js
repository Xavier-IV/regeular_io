import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-pwa-client"
export default class extends Controller {
  static targets = ['subscribeButton']

  connect() {
    const isSubscribed = localStorage.getItem('is_subscribed');

    if (isSubscribed === 'true') {
      this.subscribeButtonTarget.classList.add('hidden')
    }
  }

  subscribeUser() {
    const subscribeBtn = this.subscribeButtonTarget
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content"); // Get CSRF token

    Notification.requestPermission().then(function(permission) {
      if (permission === 'granted') {
        navigator.serviceWorker.ready.then(function(registration) {
          registration.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: window.vapidPublicKey
          }).then(function(subscription) {
            fetch('/clients/pwa_subscription', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': csrfToken // Include CSRF token in the headers
              },
              body: JSON.stringify({ subscription })
            });

            localStorage.setItem('is_subscribed', true);
            subscribeBtn.classList.add('hidden')
          }).catch(function(error) {
            console.log('Subscription failed: ', error);
          });
        });
      }
    });
  }
}
