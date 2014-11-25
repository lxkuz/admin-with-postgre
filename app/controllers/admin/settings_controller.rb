class Admin::SettingsController < Admin::AdminController
  before_action :set_settings, only: [:show, :edit, :update]

  def show
  end

  def create
    Settings.new(settings_params)
    @settings.save!
    respond_with(:admin, @settings, location: admin_settings_path)
  end

  def update
    @settings.update(settings_params)
    @settings.save!
    respond_with(:admin, @settings, location: admin_settings_path)
  end

  private

  def settings_params
    params.require(:settings).permit localized_permit(:site_name),
                                     localized_permit(:site_title),
                                     :contact_email,
                                     image_permit(:logo)
  end

  def set_settings
    @settings = Settings.first
  end
end
