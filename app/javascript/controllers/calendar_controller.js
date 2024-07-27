// app/javascript/controllers/calendar_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["container"]

  update(event) {
    const [data, status, xhr] = event.detail
    this.containerTarget.innerHTML = data
  }
}
