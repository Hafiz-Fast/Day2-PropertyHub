class Property < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    validates :location, presence: true
    validates :price,
               presence: true,
               numericality: {
                greater_than: 0
               }
    
    validate :price_must_be_even

    before_save :capitalize_title

    private
    
    def price_must_be_even
        if price.present? && price.odd?
            errors.add(:price, "must be an even number")
        end
    end

    def capitalize_title
        self.title = title.titleize
    end
end
