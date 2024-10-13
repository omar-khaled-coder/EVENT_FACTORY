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
      // Create a div to hold the custom marker HTML
      const markerDiv = document.createElement('div');
      markerDiv.innerHTML = markerData.marker_html; // Use the marker_html passed from Rails

      // Ensure the marker is clickable by adding a pointer cursor and event listener
      markerDiv.style.cursor = 'pointer';
      markerDiv.style.position = 'absolute'; // Ensure the marker is positioned absolutely

      // Create a custom marker using google.maps.OverlayView
      const customMarker = new google.maps.OverlayView();

      customMarker.onAdd = function () {
        const panes = this.getPanes();
        panes.overlayMouseTarget.appendChild(markerDiv); // Append the marker div
      };

      customMarker.draw = function () {
        const projection = this.getProjection();
        const position = new google.maps.LatLng(markerData.lat, markerData.lng);
        const point = projection.fromLatLngToDivPixel(position);
        if (point) {
          markerDiv.style.left = point.x + 'px'; // Position the marker based on projection
          markerDiv.style.top = point.y + 'px';
        }
      };

      customMarker.onRemove = function () {
        if (markerDiv.parentNode) {
          markerDiv.parentNode.removeChild(markerDiv);
        }
      };

      customMarker.setMap(this.map); // Add the custom marker to the map

      // Add the InfoWindow logic
      const infoWindow = new google.maps.InfoWindow({
        content: markerData.info_window_html
      });

      // Ensure the marker div is clickable and opens the InfoWindow
      markerDiv.addEventListener('click', () => {
        if (this.infoWindow) {
          this.infoWindow.close();
        }
        // Open the clicked marker's InfoWindow
        infoWindow.open(this.map);
        this.infoWindow = infoWindow;
        // Position the InfoWindow to be associated with the clicked marker
        infoWindow.setPosition(new google.maps.LatLng(markerData.lat, markerData.lng));
      });

      // Adjust map bounds to fit markers
      bounds.extend(new google.maps.LatLng(markerData.lat, markerData.lng));
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
