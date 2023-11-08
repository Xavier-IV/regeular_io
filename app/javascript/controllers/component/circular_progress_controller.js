import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="component--circular-progress"
export default class extends Controller {
    static targets = ['circle']
    static values = { percent: Number }

    connect(event) {
        var circle = this.circleTarget;
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;

        circle.style.strokeDasharray = `${circumference} ${circumference}`;

        setProgress(this.percentValue);

        function setProgress(percent) {
            const offset = circumference - percent / 100 * circumference;
            circle.style.strokeDashoffset = offset;
        }
    }
}
