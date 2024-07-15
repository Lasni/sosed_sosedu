import { Controller } from "@hotwired/stimulus";
import { constructLeafletMap, constructLeafletMarker } from "../leaflet_utils";

export default class extends Controller {
  static targets = ["mapDiv"];

  connect() {
    console.log("connect from leaflet_posts_index_controller");

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
  }
}
