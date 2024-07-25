import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object,
    markers: Array
  }

  connect() {
    if (typeof google === 'undefined') {
      console.error('Google Maps JavaScript API is not loaded.');
      return;
    }

    if (this.hasMarkerValue) {
      this.#initializeMapWithSingleMarker();
    } else if (this.hasMarkersValue) {
      this.#initializeMapWithMultipleMarkers();
    } else {
      console.error('No marker or markers data provided.');
    }
  }

  #initializeMapWithSingleMarker() {
    const { lat, lng } = this.markerValue;

    if (isNaN(lat) || isNaN(lng)) {
      console.error('Invalid latitude or longitude values.');
      return;
    }

    this.map = new google.maps.Map(this.element, {
      zoom: 15,
      center: { lat: lat, lng: lng }
    });

    new google.maps.Marker({
      position: { lat: lat, lng: lng },
      map: this.map
    });
  }

  #initializeMapWithMultipleMarkers() {
    this.map = new google.maps.Map(this.element, {
      zoom: 5,
      center: { lat: 0, lng: 0 }
    });

    const bounds = new google.maps.LatLngBounds();

    this.markersValue.forEach((marker) => {
      const markerInstance = new google.maps.Marker({
        position: { lat: marker.lat, lng: marker.lng },
        map: this.map
      });

      bounds.extend(markerInstance.position);
    });

    this.map.fitBounds(bounds);
  }
}
