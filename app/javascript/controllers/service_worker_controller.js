import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="service-worker"
export default class extends Controller {
  connect() {
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.register('/service-worker.js')
        .then(registration => {
          console.log('Service Worker registered:', registration)
        })
        .catch(error => {
          console.log('Service Worker registration failed:', error)
      })
    }
  }
}
