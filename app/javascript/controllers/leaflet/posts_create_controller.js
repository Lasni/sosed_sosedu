import { Controller } from "@hotwired/stimulus";
import {
  constructLeafletMap,
  constructLeafletMarker,
} from "../../utils/leaflet_utils";

// used for map with creating a post
export default class extends Controller {
  static targets = ["mapDiv", "latitude", "longitude"];

  connect() {
    console.log("leaflet posts_create_controller connect");

    let map;
    let marker;

    // extract data from rais
    const { latitude, longitude, posterUsername, ...rest } =
      this.mapDivTarget.dataset;

    // map options
    const mapOptions = {};

    // marker options
    const markerOptions = {
      title: posterUsername,
      draggable: true,
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

    // dragend function
    const dragEnd = (e) => {
      const { lat, lng } = e.target._latlng;

      this.latitudeTarget.value = lat;
      this.longitudeTarget.value = lng;
    };

    // dragend listener
    marker.on("dragend", dragEnd);
  }

  success = () => {};
  error = () => {};
}
