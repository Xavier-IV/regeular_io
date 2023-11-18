import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="toggle-submit"
export default class extends Controller {
    static targets = ["toggle"];

    connect() {
        console.log('connected1')
        // Add an event listener to the toggle input
        this.toggleTarget.addEventListener("change", this.submitForm.bind(this));
    }

    submitForm() {
        // Get the form element associated with the toggle
        const form = this.element.closest("form");
        console.log('running')
        console.log(form)
        // Submit the form when the toggle value changes
        if (form) {
            form.submit();
        }
    }
}
