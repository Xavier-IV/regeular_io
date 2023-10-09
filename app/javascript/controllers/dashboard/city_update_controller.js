import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dashboard--city-update"
export default class extends Controller {
    static targets = ["stateSelect", "citySelect"];

    defaultOption() {
        const option = document.createElement("option");
        option.value = '';
        option.textContent = 'Select a city...';
        this.citySelectTarget.appendChild(option);
        this.citySelectTarget.disabled = false;
    }

    updateCities() {
        const stateName = this.stateSelectTarget.value;
        fetch(`/cities?state=${stateName}`, {
            method: "GET",
            headers: {
                "X-Requested-With": "XMLHttpRequest",
                "Content-Type": "application/json",
            },
        })
            .then((response) => response.json())
            .then((data) => {
                this.citySelectTarget.innerHTML = ""; // Clear existing options
                this.defaultOption()
                data.cities.forEach((city) => {
                    const option = document.createElement("option");
                    option.value = city.name;
                    option.textContent = city.name;
                    this.citySelectTarget.appendChild(option);
                });
            });
    }
}
