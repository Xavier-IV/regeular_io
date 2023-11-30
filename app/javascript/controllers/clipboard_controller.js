import { Controller } from "@hotwired/stimulus"
import copy from 'copy-to-clipboard';

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["text", "helperMessage"];

  copyValue(event) {
    const button = event.currentTarget;
    const dataValue = button.getAttribute("data-value");

    this.textTarget.textContent = 'Copied!'
    this.textTarget.classList.remove('bg-white')
    this.textTarget.classList.add('bg-green-200')
    this.textTarget.classList.add('border-green-300')
    copy(dataValue);

    setTimeout(() => {
      this.textTarget.textContent = "Shareable Link";
      this.textTarget.classList.add('bg-white')
      this.textTarget.classList.remove('bg-green-200')
      this.textTarget.classList.remove('border-green-300')
    }, 3000); // 3000 milliseconds = 3 seconds
  }

  copyToClipboard() {
    this.helperMessageTarget.classList.add("invisible");
    const textToCopy = this.textTarget.title

    copy(textToCopy);

    this.helperMessageTarget.classList.remove("invisible");
  }
}
