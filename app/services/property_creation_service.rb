class PropertyCreationService
  def initialize(params)
    @params = params
  end

  def call
    property = Property.new(@params)

    if property.save
      puts "Property Created Successfully"

      # Future work:
      # Send Email
      # Notify Admin
      # Create Audit Log
    end

    return property
  end
end