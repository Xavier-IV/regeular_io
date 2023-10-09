import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["notification", "sidebar", "overlay", "content"]
    timer = 3000

    sidebarOpened = false

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
            }, 500)
        })
    }

    toggleSideBar() {
        this.sidebarOpened = !this.sidebarOpened;

        if (!this.sidebarOpened) {
            this.sidebarTarget.classList.add('hidden')
            this.sidebarTarget.classList.add('lg:flex')
            this.sidebarTarget.classList.remove('flex')
            this.sidebarTarget.classList.remove('fixed')
            this.sidebarTarget.classList.remove('h-screen')

            this.sidebarTarget.classList.remove('drop-shadow-lg')

            this.overlayTarget.classList.add('hidden')
            this.contentTarget.classList.remove('blur-sm')
        } else {
            this.sidebarTarget.classList.remove('hidden')
            this.sidebarTarget.classList.remove('lg:flex')
            this.sidebarTarget.classList.add('flex')
            this.sidebarTarget.classList.add('fixed')
            this.sidebarTarget.classList.add('h-screen')

            this.sidebarTarget.classList.add('drop-shadow-lg')

            this.overlayTarget.classList.remove('hidden')
            this.contentTarget.classList.add('blur-sm')

        }

    }
}
