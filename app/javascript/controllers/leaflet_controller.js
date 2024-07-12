import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'
import "leaflet-css"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
}

export default class extends Controller {
  static targets = ["mapDiv"]

  connect() {
    console.log('leaflet controller connect')
    this.constructLeafletMap();
  }

  constructLeafletMap() {
    if (!this.map) {    
      // Initialize Leaflet map
      this.map = L.map(this.mapDivTarget).setView([46.0771083, 14.4801205], 15);

      // Add a tile layer (you can choose different tile providers or use custom maps)
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(this.map);

      // Add marker layer for displaying current location
      this.marker = L.marker([46.0771083, 14.4801205]).addTo(this.map);

      // Call geolocation once map is initialized
      this.getCurrentPosition();

      console.log('map', this.map)
    }
  }

  getCurrentPosition() {
    navigator.geolocation.getCurrentPosition(
      pos => this.success(pos),
      err => this.error(err),
      options
    );
  }

  success = (pos) => {
    const { latitude, longitude } = pos.coords;
    this.reverseGeocode(latitude, longitude);
  }

  error = (err) => {
    console.error(`Geolocation error: ${err.message}`);
  }

  async reverseGeocode(latitude, longitude) {
    const url = `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latitude}&lon=${longitude}`;
    try {
      const response = await fetch(url);
      const data = await response.json();
      const address = data.display_name;
      console.log(`Address: ${address}`);
      this.showAddressOnMap(address, latitude, longitude);
    } catch (error) {
      console.error('Error during reverse geocoding:', error);
    }
  }

  showAddressOnMap(address, latitude, longitude) {
    if (this.marker) {
      this.marker.setLatLng([latitude, longitude]);
      this.marker.bindPopup(address).openPopup();
    } else {
      this.marker = L.marker([latitude, longitude]).addTo(this.map);
      this.marker.bindPopup(address).openPopup();
    }
  }
}
