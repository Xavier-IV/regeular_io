import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="customer--landing"
export default class extends Controller {
    static targets = ["stateSelect", "citySelect"]

    changeState(event) {
        const selectedState = event.target.value;
        const currentUrl = new URL(window.location.href);
        const params = new URLSearchParams(currentUrl.search);

        params.set("state", selectedState);
        currentUrl.search = params.toString();
        history.pushState({}, "", currentUrl);

        currentUrl.search = params.toString();
        window.location.href = currentUrl.toString();
    }

    changeCity(event) {
        const selectedCity = event.target.value;
        const currentUrl = new URL(window.location.href);
        const params = new URLSearchParams(currentUrl.search);

        params.set("city", selectedCity);
        currentUrl.search = params.toString();
        history.pushState({}, "", currentUrl);

        currentUrl.search = params.toString();
        window.location.href = currentUrl.toString();
    }
}
