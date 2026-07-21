class Property < ApplicationRecord
    # Enums
    enum :status, {
        available: 0,
        sold: 1,
        pending: 2
    }

    # Scopes are defined Console Database Queries
    scope :available, -> { where(status: "available") }
    scope :id_exists, -> { where(id in [1, 3, 5]) }
    scope :cheap, -> { where(price: ..500000) }
    scope :recent, -> { order(created_at: :desc) }

    # Property.where(city: "Lahore") can be translated to Property.in_city("Lahore")
    scope :in_city, -> (city) {
        where(city: city)
    }

    include Titleizable

    belongs_to :user
    has_many :reviews, dependent: :destroy

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
