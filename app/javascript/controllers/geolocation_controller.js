import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
}

export default class extends Controller {
  static targets = ["latitude", "longitude"]

  connect() {
    this.promptGeolocationPermission();
  }

  promptGeolocationPermission() {
    navigator.permissions.query({ name: 'geolocation' })
      .then(permissionStatus => {
        if (permissionStatus.state === 'prompt') {
          // You can customize the alert or use a more advanced modal here
          if (confirm('Allow this app to access your location?')) {
            this.getCurrentPosition();
          } else {
            console.log('User denied geolocation permission');
            // Handle denied permission
          }
        } else if (permissionStatus.state === 'granted') {
          this.getCurrentPosition();
        } else {
          console.log('Geolocation permission is denied or dismissed');
          // Handle denied or dismissed permission
        }
      })
      .catch(err => {
        console.error('Error querying geolocation permission:', err);
      });
  }

  getCurrentPosition() {
    navigator.geolocation.getCurrentPosition(
      pos => this.success(pos),
      err => this.error(err),
      options
    );
  }

  success = (pos) => {
    const crd = pos.coords;
    console.log('Your current position is:');
    console.log(`Latitude: ${crd.latitude}`);
    console.log(`Longitude: ${crd.longitude}`);
    console.log(`More or less: ${crd.accuracy} meters`);

    this.latitudeTarget.value = crd.latitude;
    this.longitudeTarget.value = crd.longitude;
  }

  error = (err) => {
    console.warn(`Error:${err.code}: ${err.message}`);
  }
}
