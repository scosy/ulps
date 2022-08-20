module EpisodesHelper
    def price_str(price_in_cents)
        (price_in_cents / 100).to_s + "," + (price_in_cents % 100).to_s.rjust(2, "0") + " €"
    end
end
