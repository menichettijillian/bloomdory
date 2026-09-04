import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "messages"]

  connect() {
    this.scrollToLastMessage()
  }

  submitWithEnter(event) {
    if (event.key !== "Enter" || event.shiftKey) return

    event.preventDefault()

    if (event.target.value.trim() === "") return

    this.formTarget.requestSubmit()
  }

  scrollToLastMessage() {
    requestAnimationFrame(() => {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    })
  }
}
