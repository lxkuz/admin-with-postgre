class Admin::AttachmentsController < Admin::AdminController
  include ActionView::Helpers::NumberHelper

  def destroy
    Attachment.find(params[:id]).destroy
    request.xhr? ? render(text: true) : redirect_to(admin_attachments_path)
  end

  def create
    @attachment = Attachment.create file: params[:file]
    render json: { filelink: @attachment.file.try(:url), filename: '', id: @attachment.id.to_s }
  end

  def index
    res = Attachment.where(target: nil).map do |p|
      { size: number_to_human_size(p.file.size), link: p.file.try(:url), id: p.id.to_s, name: File.extname(p.file_name), title: File.basename(p.file_name, '.*' ) }
    end
    render json: res
  end
end