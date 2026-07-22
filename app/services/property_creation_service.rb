class PropertyCreationService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    property = Property.new(@params)
    property.user = @user
    property.save

    return property
  end
end