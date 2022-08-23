class PublicController < ApplicationController
  before_action :disable_nav, only: :index

  def index
    @partners = [
      { name: "stripe", url: "https://stripe.com", reason: "Merci à Stripe d'être mon partenaire de paiement préféré depuis mes débuts avec Shift Heroes !" },
      { name: "heroku", url: "https://heroku.com", reason: "Merci à Heroku qui héberge quasiment toutes mes applications web" },
      { name: "42", url: "https://42.fr", reason: "Merci" },
      { name: "github", url: "https://github.com", reason: "Merci" },
      { name: "rails", url: "https://rubyonrails.org", reason: "Merci" },
      { name: "dougs", url: "https://dougs.fr", reason: "Merci" },
      { name: "amazon", url: "https://amazon.fr", reason: "Merci" },
      { name: "audiomeans", url: "https://audiomeans.com", reason: "Merci" }
    ]
  end

  def privacy
  end

  def conditions
  end
end
