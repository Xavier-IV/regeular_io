import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="qr--rating"
export default class extends Controller {
  static targets = ["ratingInput", "descriptionInputTarget"];

  setRating(event) {
    const selectedRating = event.target.value;
    this.ratingInputTarget.value = selectedRating;
  }

  toggleRating(event) {
    const selectedRating = event.target.value;
    this.ratingInputTarget.value = selectedRating;

    // Remove the color from all stars
    this.element.querySelectorAll(".star").forEach((star) => {
      star.classList.remove("text-yellow-500");
      star.classList.add("text-gray-300");
    });

    // Apply color to selected stars
    this.element.querySelectorAll(".star").forEach((star, index) => {
      if (index < selectedRating) {
        star.classList.remove("text-gray-300");
        star.classList.add("text-yellow-500");
      }
    });
  }
}
