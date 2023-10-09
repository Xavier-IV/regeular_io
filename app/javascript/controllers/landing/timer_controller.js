import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--timer"
export default class extends Controller {
  static targets = ["timerButton", "timerButtonPlaceholder"]

  startTimer() {
    let remainingSeconds = 120; // 2 minutes in seconds

    this.timerButtonPlaceholderTarget.classList.add('invisible')
    this.timerButtonPlaceholderTarget.classList.remove('hidden')

    this.timerButtonTarget.classList.add('fixed')
    this.timerButtonTarget.classList.add('bottom-0')
    this.timerButtonTarget.classList.add('left-10')

    this.timerButtonTarget.innerText = `${remainingSeconds} seconds`
    remainingSeconds -= 1;

    const interval = setInterval(() => {
      if (remainingSeconds > 0) {
        this.timerButtonTarget.innerText = `${remainingSeconds} seconds remaining`
        remainingSeconds -= 1;
      } else {
        clearInterval(interval);
        this.timerButtonTarget.innerText = "Timer Finished";

        this.timerButtonPlaceholderTarget.classList.remove('invisible')
        this.timerButtonPlaceholderTarget.classList.add('hidden')

        this.timerButtonTarget.classList.remove('fixed')
        this.timerButtonTarget.classList.remove('bottom-0')
        this.timerButtonTarget.classList.remove('left-10')
      }
    }, 1000);
  }
}
