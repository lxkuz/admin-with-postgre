class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  responders :flash, :http_cache, :collection
  
end
