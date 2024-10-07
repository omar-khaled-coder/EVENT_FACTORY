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

    this.infoWindow = null;  // To track the currently open info window

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

    const marker = new google.maps.Marker({
      position: { lat: lat, lng: lng },
      map: this.map
    });

    // info widow for show page ..
    //const infoWindow = new google.maps.InfoWindow({
      //content: this.markerValue.info_window_html
    //});

    //marker.addListener('click', () => {
      //this.#toggleInfoWindow(infoWindow, marker);
    //});
  }

  #initializeMapWithMultipleMarkers() {
    this.map = new google.maps.Map(this.element, {
      zoom: 5,
      center: { lat: 0, lng: 0 }
    });

    const bounds = new google.maps.LatLngBounds();

    this.markersValue.forEach((markerData) => {
      const marker = new google.maps.Marker({
        position: { lat: markerData.lat, lng: markerData.lng },
        map: this.map
      });

      const infoWindow = new google.maps.InfoWindow({
        content: markerData.info_window_html
      });

      marker.addListener('click', () => {
        this.#toggleInfoWindow(infoWindow, marker);
      });

      bounds.extend(marker.position);
    });

    this.map.fitBounds(bounds);
  }

  // This method toggles the info window
  #toggleInfoWindow(infoWindow, marker) {
    // If there's already an open info window, close it
    if (this.infoWindow) {
      this.infoWindow.close();
    }

    // If the clicked info window is different, open it
    if (this.infoWindow !== infoWindow) {
      infoWindow.open(this.map, marker);
      this.infoWindow = infoWindow;
    } else {
      // If the clicked info window is the same, toggle it off
      this.infoWindow = null;
    }
  }
}
