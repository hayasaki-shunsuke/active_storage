# frozen_string_literal:true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def after_sign_in_path_for(resource)
    '/books'
  end

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
