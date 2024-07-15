import { Controller } from "@hotwired/stimulus";
import {
  constructLeafletMap,
  constructLeafletMarker,
} from "../../utils/leaflet_utils";
import { reverseGeocode } from "../../utils/geolocation_utils";

export default class extends Controller {
  static targets = ["mapDiv"];

  connect() {
    console.log("leaflet posts_show_controller connect");

    let map;
    let marker;

    const { latitude, longitude, posterUsername, ...rest } =
      this.mapDivTarget.dataset;

    // map options
    const mapOptions = {};

    // marker options
    const markerOptions = {
      title: posterUsername,
      draggable: false,
    };

    // construct the map
    map = constructLeafletMap(
      this.mapDivTarget,
      parseFloat(latitude),
      parseFloat(longitude),
      15,
      mapOptions
    );

    // construct the marker
    marker = constructLeafletMarker(latitude, longitude, markerOptions);

    // add marker to the map
    marker.addTo(map);

    reverseGeocode(latitude, longitude).then((address) => {
      marker.bindPopup(address).openPopup();
    });
  }

  success = () => {};
  error = () => {};
}
