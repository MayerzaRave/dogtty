import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import mapboxgl from "mapbox-gl";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {

  static values = {
    apiKey: String
  }

  static targets = ["address", "longitude", "latitude"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element, // container ID
      style: 'mapbox://styles/mapbox/streets-v11', // style URL
      center: [-75.573553, 6.2443382],
      zoom: 5
    });

    const geocoder = new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl })
    this.map.addControl(geocoder)

    geocoder.on('result', (event) => {

      let address = event.result["place_name"]
      let coordinates = event.result["center"]
      let longitude = coordinates[0]
      let latitude = coordinates[1]

      this.addressTarget.value = address
      this.longitudeTarget.value = longitude
      this.latitudeTarget.value = latitude
    });

    geocoder.on('clear', (event) => {
      this.addressTarget.value = ""
    });

  }
}
