import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["guestNumber", "guestNumberError", "startTime", "endTime", "priceCalculation", "bookingPrice"]

  connect() {
    // Log to ensure data attributes are being passed correctly
    console.log("Max Capacity:", this.maxCapacityValue)
    console.log("Price Per Hour:", this.pricePerHourValue)
    console.log("Min Hours:", this.minHoursValue)

    this.calculatePrice()
  }

  validateGuestNumber() {
    const value = parseInt(this.guestNumberTarget.value)
    const maxCapacity = this.maxCapacityValue
    const minCapacity = this.minCapacityValue

    if (value > maxCapacity) {
      this.guestNumberErrorTarget.textContent = `The number of guests cannot exceed ${maxCapacity}.`
      this.guestNumberTarget.value = maxCapacity
    } else if (value < minCapacity) {
      this.guestNumberErrorTarget.textContent = `The number of guests cannot be less than ${minCapacity}.`
      this.guestNumberTarget.value = minCapacity
    } else {
      this.guestNumberErrorTarget.textContent = ''
    }
  }

  calculatePrice() {
    const startTime = this.startTimeTarget.value
    const endTime = this.endTimeTarget.value
    const pricePerHour = this.pricePerHourValue
    const minHours = this.minHoursValue

    if (startTime && endTime) {
      const start = new Date(`1970-01-01T${startTime}:00`)
      const end = new Date(`1970-01-01T${endTime}:00`)
      const hours = (end - start) / (1000 * 60 * 60)

      const calculatedHours = hours < minHours ? minHours : hours
      const spacePrice = pricePerHour * calculatedHours
      const estimatedPrice = spacePrice

      this.priceCalculationTarget.innerHTML = `
        <p>Space price: $${pricePerHour} x ${calculatedHours} hrs: $${spacePrice.toFixed(2)}</p>
        <p>Estimated price: $${estimatedPrice.toFixed(2)}</p>
      `
      this.bookingPriceTarget.value = estimatedPrice.toFixed(2)
    }
  }

  get maxCapacityValue() {
    return parseInt(this.data.get("maxCapacityValue"))
  }

  get minCapacityValue() {
    return parseInt(this.data.get("minCapacityValue"))
  }

  get pricePerHourValue() {
    return parseFloat(this.data.get("pricePerHourValue"))
  }

  get minHoursValue() {
    return parseFloat(this.data.get("minHoursValue"))
  }
}
