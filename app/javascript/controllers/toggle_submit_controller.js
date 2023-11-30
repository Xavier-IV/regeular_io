import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="toggle-submit"
export default class extends Controller {
    static targets = ["toggle"];

    connect() {
        this.toggleTarget.addEventListener("change", this.submitForm.bind(this));
    }

    submitForm() {
        // Get the form element associated with the toggle
        const form = this.element.closest("form");
        if (form) {
            form.submit();
        }
    }
}
