module RequestLogger
  extend ActiveSupport::Concern

  included do
    before_action :log_request
  end

  private

  def log_request
    Rails.logger.info "Processing #{controller_name}##{action_name}"
  end
end