module PropertiesHelper
  def formatted_price(property)
    "PKR #{number_with_delimiter(property.price)}"
  end

  def property_location(property)
    "#{property.location}"
  end
end