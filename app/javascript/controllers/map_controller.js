import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    if (typeof google === 'undefined') {
      console.error('Google Maps JavaScript API is not loaded.');
      return;
    }

    this.map = new google.maps.Map(this.element, {
      zoom: 5,
      center: { lat: 0, lng: 0 }
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new google.maps.Marker({
        position: { lat: marker.lat, lng: marker.lng },
        map: this.map
      });
    });
  }

  #fitMapToMarkers() {
    const bounds = new google.maps.LatLngBounds();
    this.markersValue.forEach(marker => {
      bounds.extend(new google.maps.LatLng(marker.lat, marker.lng));
    });
    this.map.fitBounds(bounds);
  }
}
