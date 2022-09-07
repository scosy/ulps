# frozen_string_literal: true

class PublicController < ApplicationController
  before_action :disable_nav, only: :index

  def index
    @partners = [
      { name: 'stripe', url: 'https://stripe.com',
        reason: "Merci à Stripe d'être mon partenaire de paiement préféré depuis mes débuts avec Shift Heroes !" },
      { name: 'heroku', url: 'https://heroku.com',
        reason: 'Merci à Heroku qui héberge quasiment toutes mes applications web' },
      { name: '42', url: 'https://42.fr',
        reason: "Merci à l'école 42 de m'avoir ouvert les yeux sur mes possibilités" },
      { name: 'github', url: 'https://github.com', reason: 'Merci à GitHub pour tout ça' },
      { name: 'rails', url: 'https://rubyonrails.org', reason: 'Merci à Rails qui est devenu un très bon pote' },
      { name: 'dougs', url: 'https://www.dougs.fr?r=ODwK1GYdji',
        reason: "Merci à Dougs de m'aider à gérer ma compta facilement" },
      { name: 'amazon', url: 'https://amzn.to/3cc7Gye', reason: 'Merci à Amazon de remplir ma bibliothèque' },
      { name: 'audiomeans', url: 'https://audiomeans.com', reason: "Merci à Audiomeans pour l'hébergement de mes tous mes audios." }
    ]
  end

  def privacy; end

  def conditions; end
end
