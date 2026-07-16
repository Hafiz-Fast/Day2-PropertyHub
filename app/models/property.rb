class Property < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    validates :location, presence: true
    validates :price,
               presence: true,
               numericality: {
                greater_than: 0
               }
    
    validate :price_must_be_even

    private
    
    def price_must_be_even
        if price.present? && price.odd?
            errors.add(:price, "must be an even number")
        end
    end
end
