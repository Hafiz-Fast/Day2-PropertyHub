class PropertiesController < ApplicationController
    include RequestLogger

    def index
        @properties = Property.all

        respond_to do |format|
            format.html
            format.json { render json: @properties }
        end
    end

    def create
        @property = PropertyCreationService.new(property_params).call

        if @property.persisted?
            redirect_to @property
        else
            render :new, status: :unprocessable_entity
        end
    end

    def search
        @properties = Property.where(city: params[:city])
    end

    def favorite
        @property = Property.find(params[:id])

        # Favorite this property
    end

  private

  def property_params
    params.require(:property).permit(:title, :price, :location)
  end
end
