class User < ApplicationRecord
    has_many :properties, dependent: :destroy
    has_many :reviews, through: :properties

    has_many :favorites, dependent: :destroy
    has_many :favorite_properties, through: :favorites, source: :property
end