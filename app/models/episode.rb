class Episode < ApplicationRecord
    belongs_to :book

    def price_str
        (price / 100).to_s + "," + (price % 100).to_s.rjust(2, "0") + " €"
    end

end
