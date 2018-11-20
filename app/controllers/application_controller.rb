class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  # skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    permits = [:sign_up, :account_update]
    keys = [:email, :name, :birthday]
    permits.each do |p|
      devise_parameter_sanitizer.permit(p, keys: keys)
    end
  end
end
