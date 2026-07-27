class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Devise handles password assignment and writes the BCrypt hash to
  # encrypted_password. `password` is only a virtual form attribute.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :age ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :age ])
  end
end
