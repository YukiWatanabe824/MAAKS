import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import mapboxgl from 'mapbox-gl'; // or "const mapboxgl = require('mapbox-gl');"
 
mapboxgl.accessToken = 'pk.eyJ1IjoieXVraXdhdGFuYWJlIiwiYSI6ImNsamx3NmQ2NzEwZTczZXBwOTUzbDE5amsifQ.ep62YrWWsdT4HtVFLVA-Og';
const map = new mapboxgl.Map({
container: 'map', // container ID
style: 'mapbox://styles/yukiwatanabe/cljqcpwss004501oc6qhs4rek', // style URL
center: [139.81010425, 35.71001875], // starting position [lng, lat]
zoom: 9, // starting zoom
});


