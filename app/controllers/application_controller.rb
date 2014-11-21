class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  layout proc { devise_controller? ? 'admin_blank' : 'application' }
  respond_to :html

  private

  def default_url_options(*)
    { locale: I18n.locale }
  end

  def set_locale
    locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = locale
    I18n.locale = locale
  end
end
