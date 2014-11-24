class Admin::UsersController < Admin::AdminController
  before_action :set_resource, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs, except: [:index, :destroy]
  include Scopable

  def index
    @collection = apply_scopes(User).page params[:page]
    @breadcrumbs = [{ name: t('admin.navigation.root'), url: admin_dashboard_path }, { name: t('admin.users.index.title') }]
    respond_with @collection
  end

  def new
    @resource = User.new
    respond_with(:admin, @resource)
  end

  def edit
  end

  def create
    @resource = User.new(resource_params)
    @resource.save
    respond_with(:admin, @resource)
  end

  def update
    @resource.update(resource_params)
    respond_with(:admin, @resource)
  end

  def destroy
    @resource.destroy
    respond_with(:admin, @resource)
  end

  private

  def set_resource
    @resource = User.find(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = [{ name: t('admin.navigation.root'), url: admin_dashboard_path }, { name: t('admin.users.index.title'), url: admin_users_path }, { name: t('.title') }]
  end

  def resource_params
    pp = [:email]
    pp += [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit *pp
  end
end
