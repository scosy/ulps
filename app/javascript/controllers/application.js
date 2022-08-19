import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
    var grid = document.querySelector('.episodes');
    var msnry = new Masonry( grid, {
        itemSelector: '.episode',
        percentPosition: true
  });
})
  