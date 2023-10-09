import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="landing--business--faq"
export default class extends Controller {

    static targets = ['accordionBody', 'accordionTitle']

    active = null

    toggle(event) {
        if (this.active === Number(event.params.id) - 1) {
            this.active = null
            this.closeAll()
            return
        }

        this.active = Number(event.params.id) - 1

        if (this.active === null) return

        this.closeAll()
        this.accordionBodyTargets[this.active].classList.remove('hidden')
        this.accordionTitleTargets[this.active].classList.add('bg-slate-100')
    }

    closeAll(event) {
        this.accordionTitleTargets.forEach(t => t.classList.remove('bg-slate-100'))

        this.accordionBodyTargets.forEach(t => t.classList.add('hidden'))
    }
}
