// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "chartkick/chart.js"

import "./controllers/pages/home"

import { initFlatpickr } from "./plugins/flatpickr";
initFlatpickr();
