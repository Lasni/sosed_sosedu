import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="burek"
export default class extends Controller {
  static targets = ["burek"]
  connect() {
    console.log('connect form burek')
  }
}
