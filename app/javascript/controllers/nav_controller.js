import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["menu", "content", "other-layer"]

    sidebarOpened = false

    closeAll(e) {
        if (e.target.classList.contains('lni-menu')) return;
        this.close()
    }

    toggle(e) {
        this.executeToggle(e)
    }

    close() {
        if (!this.sidebarOpened) return;
        this.sidebarOpened = !this.sidebarOpened;
        this.contentTarget.classList.add('hidden')
    }

    executeToggle(e) {
        this.sidebarOpened = !this.sidebarOpened;

        if (!this.sidebarOpened) {
            this.contentTarget.classList.add('hidden')
        } else {
            this.contentTarget.classList.remove('hidden')
        }
    }
}
