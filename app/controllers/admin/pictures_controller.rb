class Admin::PicturesController < Admin::AdminController
  def destroy
    Picture.find(params[:id]).destroy
    request.xhr? ? render(text: true) : redirect_to(admin_pictures_path)
  end

  def create
    @picture = Picture.create file: params[:file]
    render json: { filelink: @picture.file.try(:url), filename: '', id: @picture.id.to_s }
  end

  def index
    res = Picture.where(target: nil).map do |p|
      { thumb: p.file.thumb('100x75#').url, image: p.file.try(:url), title: '', id: p.id.to_s }
    end
    render json: res
  end
end