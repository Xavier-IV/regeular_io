import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="landing--customer"
export default class extends Controller {
    static targets = ['overlay', 'overlayContent']

    flipped = false

    connect() {
    }

    openMap() {
        amplitude.track('customer.landing.open_map');
    }

    flipCard() {
        this.flipped = !this.flipped
        if (this.flipped) {
            amplitude.track('customer.landing.flip_card');
            this.overlayTarget.classList.remove('hidden')
            this.overlayContentTargets.forEach((target) => {
                target.classList.remove('hidden')
            })
        } else {
            amplitude.track('customer.landing.unflip_card');
            this.overlayTarget.classList.add('hidden')
            this.overlayContentTargets.forEach((target) => {
                target.classList.add('hidden')
            })
        }
    }
}
