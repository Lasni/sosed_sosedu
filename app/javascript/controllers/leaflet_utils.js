import L from 'leaflet'
import "leaflet-css"

export function constructLeafletMap(target, latitude, longitude, zoom, mapOptions={}) {
  // Initialize Leaflet map
  const map = L.map(target).setView([latitude, longitude], zoom, mapOptions);

  // Add a tile layer (you can choose different tile providers or use custom maps)
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);
  return map
}

export function constructLeafletMarker(latitude, longitude, markerOptions={}) {
  // Construch a marker for displaying current location
  const marker = L.marker([latitude, longitude], markerOptions)
  return marker
}