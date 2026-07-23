class PropertiesController < ApplicationController
    include RequestLogger

    before_action :set_property, only: %i[show edit update destroy favorite]

    def index
        @properties = Property.includes(:user).order(created_at: :asc).page(params[:page]).per(5)         # Pagination

        respond_to do |format|
            format.html
            format.json { render json: @properties }
        end
    end

    def new
        @property = Property.new
    end

    def create
        @property = PropertyCreationService.new(property_params, User.first).call
        @property.user = User.first

        if @property.persisted?
            redirect_to @property
        else
            render :new, status: :unprocessable_entity
        end
    end

    def search
        @properties = Property.where(location: params[:location])
    end

    def favorite
        @property = Property.find(params[:id])

        # Favorite this property
    end

    def show
    end

    def edit
    end

    def update
        if @property.update(property_params)
            redirect_to @property, notice: "Property updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @property.destroy
        redirect_to properties_path, notice: "Property deleted"
    end

  private

    def set_property
        @property = Property.find(params[:id])
    end

    def property_params
        params.require(:property).permit(:title, :price, :location)
    end
end
