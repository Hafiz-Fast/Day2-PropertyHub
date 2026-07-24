module PropertiesHelper
  def formatted_price(property)
    "PKR #{number_with_delimiter(property.price)}"
  end

  def property_location(property)
    "#{property.location}"
  end

  def favorited_property?(property)
    @favorite_property_ids&.include?(property.id)
  end
end
