class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  responders :flash, :http_cache, :collection

  protected

  def localized_permit name
    obj = {}
    obj[name] = I18n.available_locales
    obj
  end

  def image_permit(param)
    [
      param.to_sym, "#{param}_uid".to_sym,
      "#{param}_name".to_sym,
      "remove_#{param}".to_sym,
      "retained_#{param}".to_sym
    ]
  end
  
end
