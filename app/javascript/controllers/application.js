import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    if(document.querySelector('#celebrate')) {
        party.confetti(document.querySelector('#celebrate'), {
            count: party.variation.range(150, 200),
            size: party.variation.range(0.5, 1.5)
        });
        setTimeout(function() {
            party.confetti(document.querySelector('#celebrate'), {
                count: party.variation.range(20, 40),
                size: party.variation.range(0.5, 1.5)
            });
        }, 400);
    }
})
  