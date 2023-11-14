import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="overscroll-refresh"
export default class extends Controller {
    // connect() {
    //     window.addEventListener("scroll", this.checkOverscroll.bind(this));
    // }
    //
    // disconnect() {
    //     window.removeEventListener("scroll", this.checkOverscroll.bind(this));
    // }

    checkOverscroll() {
        const scrollY = window.scrollY;

        // Define the threshold for overscroll (e.g., 100 pixels)
        const overscrollThreshold = 200;

        if (scrollY <= overscrollThreshold) {
            // Refresh the page when overscroll is detected
            location.reload();
        }
    }
}
