import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="burek"
export default class extends Controller {
  static targets = ["bunga"]
  connect() {
    console.log('connect from leaflet_posts_index_controller')
  }
}
