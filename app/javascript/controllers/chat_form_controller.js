import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "messages", "input", "submitButton"]

  connect() {
    this.isSubmitting = false
    this.originalSubmitValue = this.submitButtonTarget.value
    this.toggleSubmitButton()
    this.scrollToLastMessage()
  }

  toggleSubmitButton() {
    if (this.isSubmitting) return

    this.submitButtonTarget.disabled = this.inputTarget.value.trim() === ""
  }

  submitWithEnter(event) {
    if (event.key !== "Enter" || event.shiftKey) return

    event.preventDefault()

    if (event.target.value.trim() === "") return
    if (this.isSubmitting) return

    this.formTarget.requestSubmit(this.submitButtonTarget)
  }

  preventDuplicateSubmit(event) {
    if (this.isSubmitting) {
      event.preventDefault()
      return
    }

    this.isSubmitting = true
    this.inputTarget.readOnly = true
    this.submitButtonTarget.value = "Enviando..."
    this.submitButtonTarget.disabled = true
  }

  unlockForm() {
    this.isSubmitting = false
    this.inputTarget.readOnly = false
    this.submitButtonTarget.value = this.originalSubmitValue
    this.toggleSubmitButton()
  }

  scrollToLastMessage() {
    requestAnimationFrame(() => {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    })
  }
}
