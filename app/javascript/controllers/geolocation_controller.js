import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
}

export default class extends Controller {
  static targets = ["latitude", "longitude"]

  connect() {
    console.log('geolocation controller connect')
    this.promptGeolocationPermission();
  }

  promptGeolocationPermission() {
    navigator.permissions.query({ name: 'geolocation' })
      .then(permissionStatus => {
        if (permissionStatus.state === 'prompt') {
          if (confirm('Allow this app to access your location?')) {
            this.getCurrentPosition();
          } else {
            console.log('User denied geolocation permission');
            this.handleDeniedPermission();
          }
        } else if (permissionStatus.state === 'granted') {
          this.getCurrentPosition();
        } else {
          console.log('Geolocation permission is denied or dismissed');
          this.handleDeniedPermission();
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
    this.handleDeniedPermission();
  }

  handleDeniedPermission() {
    alert("We could not access your location. You will not be able to use the full functionality of this website. Please refresh your browser and grant it location permission.")
  }
}
