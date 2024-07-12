# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
# pin "@googlemaps/js-api-loader", to: "@googlemaps--js-api-loader.js" # @1.16.6

# pin "leaflet", to: "leaflet/dist/leaflet.js"

pin "leaflet" # @1.9.4
pin "leaflet-css" # @0.1.0
# pin "leaflet-css", to: "https://ga.jspm.io/npm:leaflet-css@0.1.0/dist/leaflet.css.min.js"

