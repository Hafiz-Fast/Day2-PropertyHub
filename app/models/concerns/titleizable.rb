module Titleizable
  extend ActiveSupport::Concern

  included do
    before_save :capitalize_title
  end

  private

  def capitalize_title
    self.title = title.titleize if respond_to?(:title) && title.present?
  end
end