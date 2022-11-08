import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    window: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element, // container ID
      style: 'mapbox://styles/mapbox/streets-v11', // style URL
      center: [-75.573553, 6.2443382],
      zoom: 5
    });

    this.#addMarkersToMap()

    const geocoder = new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl, marker: false })
    this.map.addControl(geocoder)
    // console.log(geocoder)

    geocoder.on('result', (event) => {

      let address = event.result["place_name"]
      let coordinates = event.result["center"]
      let longitude = coordinates[0]
      let latitude = coordinates[1]

      this.#addSearchMarkerToMap(longitude, latitude, this.windowValue)
    });

  }

  #addMarkersToMap () {
    new mapboxgl.Marker()
      .setLngLat([-75.573553, 0])
      .addTo(this.map)
  }

  #addSearchMarkerToMap (lng, ltd, popupWindow) {
    let popup = new mapboxgl.Popup().setHTML(popupWindow)
    new mapboxgl.Marker()
      .setLngLat([lng, ltd])
      .setPopup(popup)
      .addTo(this.map)

  }

}
