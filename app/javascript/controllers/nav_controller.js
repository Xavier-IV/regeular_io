import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["menu", "content"]

    sidebarOpened = false

    toggle() {
        this.sidebarOpened = !this.sidebarOpened;

        if (!this.sidebarOpened) {
            this.contentTarget.classList.add('hidden')
        } else {
            this.contentTarget.classList.remove('hidden')
        }

    }
}
