import { Controller } from "@hotwired/stimulus"
import { constructLeafletMap, constructLeafletMarker } from "../leaflet_utils";

// used for map with creating a post
export default class extends Controller {
  static targets = ["mapDiv", "latitude", "longitude"]

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
    map = constructLeafletMap(this.mapDivTarget, parseFloat(latitude), parseFloat(longitude), 15, mapOptions);

    // construct the marker
    marker = constructLeafletMarker(latitude, longitude, markerOptions)

    // add marker to the map
    marker.addTo(map)

    // dragend function
    const dragEnd = (e) => {
      const { lat, lng } = e.target._latlng
      console.log('lat', lat)
      console.log('lng', lng)
      

      this.latitudeTarget.value = lat;
      this.longitudeTarget.value = lng;

      console.log('this.latitudeTarget', this.latitudeTarget)
      console.log('this.longitudeTarget', this.longitudeTarget)

      // const latitudeHiddenFieldEl = document.getElementById('latitudeHiddenField')
      // const longitudeHiddenFieldEl = document.getElementById('longitudeHiddenField')

      // console.log('latitudeHiddenFieldEl', latitudeHiddenFieldEl)
      // console.log('longitudeHiddenFieldEl', longitudeHiddenFieldEl)

      // latitudeHiddenFieldEl.value = lat;
      // longitudeHiddenFieldEl.value = lng;
      
    }

    // dragend listener
    marker.on('dragend', dragEnd)
  }

  // dragend method
  // dragEnd(e) {
  //   console.log('dragEnd', e)
  //   console.log('this.latitudeTarget', this)
  //   // console.log('this.longitudeTarget', this.longitudeTarget)
  // }



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
