import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
    // Only if .episodes is present on the page
    if (document.querySelector(".episodes")) {
        var grid = document.querySelector('.episodes');
        var msnry = new Masonry( grid, {
            itemSelector: '.episode',
            percentPosition: true
        });
    }
})
  