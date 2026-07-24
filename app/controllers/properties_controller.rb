class PropertiesController < ApplicationController
    include RequestLogger

    before_action :set_property, only: %i[show edit update destroy favorite]

    def index
        @properties = Property.includes(:user).order(created_at: :asc).page(params[:page]).per(5)         # Pagination
        load_favorite_property_ids

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

        respond_to do |format|
            if @property.persisted?
                format.html do
                    redirect_to properties_path, notice: "Property created."
                end

                format.turbo_stream
            else
                format.html do
                    render :new, status: :unprocessable_entity
                end
            end
        end
    end

    def search
        @properties = Property.where(location: params[:location])
    end

    def favorite
        user = User.first

        if user.favorites.exists?(property: @property)
            user.favorites.find_by(property: @property)&.destroy
            notice = "Removed from favorites."
        else
            user.favorites.create(property: @property)
            notice = "Added to favorites."
        end

        redirect_back fallback_location: properties_path, notice: notice
    end

    def favorites
        @properties = User.first.favorite_properties.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
        @favorite_property_ids = @properties.map(&:id)
    end

    def show
        @favorite_property_ids = User.first.favorites.where(property: @property).pluck(:property_id)
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

    def load_favorite_property_ids
        @favorite_property_ids = User.first.favorite_properties.where(id: @properties.select(:id)).pluck(:id)
    end
end
