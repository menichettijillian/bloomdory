import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      group: 'shared',
      animation: 150,
      ghostClass: 'bg-light',
      onEnd: this.end.bind(this)
    })
  }

  disconnect() {
    this.sortable.destroy()
  }

  end(event) {
    // Si el elemento no se movió de columna, no hacemos nada
    if (event.from === event.to && event.oldIndex === event.newIndex) return

    let itemId = event.item.dataset.id
    let newDate = event.to.dataset.date
    let newPosition = event.newIndex

    let data = new FormData()
    data.append("position", newPosition + 1)
    if (newDate) {
      data.append("date", newDate)
    }

    let url = this.urlValue.replace(':id', itemId)

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
        "Accept": "text/javascript"
      },
      body: data
    })
    .then(response => {
      if (response.ok) {
        // Opcional: recargar la página o dejar que Turbo actúe para reflejar el cambio ordenado
        window.location.reload()
      } else {
        console.error("Error al mover el evento")
      }
    })
  }
}
