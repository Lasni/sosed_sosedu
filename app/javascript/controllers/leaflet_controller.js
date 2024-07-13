import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'
import "leaflet-css"

export default class extends Controller {
  static targets = ["mapDiv"]

  connect() {
    console.log('leaflet controller connect')
    let map;
    let marker;

    // extract data from rais
    const { latitude, longitude, posterUsername, ...rest } = this.mapDivTarget.dataset;

    // map options
    const mapOptions = {
    }

    // marker options
    const markerOptions = {
      title: posterUsername,
      draggable: true
    }

    // construct the map
    map = this.constructLeafletMap(parseFloat(latitude), parseFloat(longitude), 15, mapOptions);

    // construct the marker
    marker = this.constructLeafletMarker(latitude, longitude, markerOptions)

    // add marker to the map
    marker.addTo(map)
  }

  constructLeafletMap(latitude, longitude, zoom, mapOptions) {
      // Initialize Leaflet map
      const map = L.map(this.mapDivTarget).setView([latitude, longitude], zoom, mapOptions);

      // Add a tile layer (you can choose different tile providers or use custom maps)
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map);
      return map
  }

  constructLeafletMarker(latitude, longitude, markerOptions) {
    // Add marker layer for displaying current location
    const marker = L.marker([latitude, longitude], markerOptions)
    return marker
  }


  // getCurrentPosition() {
  //   navigator.geolocation.getCurrentPosition(
  //     pos => this.success(pos),
  //     err => this.error(err),
  //     options
  //   );
  // }

  // success = (pos) => {
  //   const { latitude, longitude } = pos.coords;
  //   this.reverseGeocode(latitude, longitude);
  // }

  // error = (err) => {
  //   console.error(`Geolocation error: ${err.message}`);
  // }

  // async reverseGeocode(latitude, longitude) {
  //   const url = `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latitude}&lon=${longitude}`;
  //   try {
  //     const response = await fetch(url);
  //     const data = await response.json();
  //     const address = data.display_name;
  //     console.log(`Address: ${address}`);
  //     this.showAddressOnMap(address, latitude, longitude);
  //   } catch (error) {
  //     console.error('Error during reverse geocoding:', error);
  //   }
  // }

  // showAddressOnMap(address, latitude, longitude) {
  //   if (this.marker) {
  //     this.marker.setLatLng([latitude, longitude]);
  //     this.marker.bindPopup(address).openPopup();
  //   } else {
  //     this.marker = L.marker([latitude, longitude]).addTo(this.map);
  //     this.marker.bindPopup(address).openPopup();
  //   }
  // }
}
