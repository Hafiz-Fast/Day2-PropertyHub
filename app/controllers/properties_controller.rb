class PropertiesController < ApplicationController
    def index
        @properties = Property.all

        respond_to do |format|
            format.html
            format.json { render json: @properties }
        end
    end

    def create
        @property = Property.new(property_params)

        if @property.save
            redirect_to @property
        else
            render :new, status: :unprocessable_entity
        end
    end

  private

  def property_params
    params.require(:property).permit(:title, :price, :location)
  end
end
