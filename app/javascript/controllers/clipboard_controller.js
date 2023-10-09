import { Controller } from "@hotwired/stimulus"
import copy from 'copy-to-clipboard';

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["text", "helperMessage"];

  copyToClipboard() {
    this.helperMessageTarget.classList.add("invisible");
    const textToCopy = this.textTarget.title

    copy(textToCopy);

    this.helperMessageTarget.classList.remove("invisible");
  }
}
