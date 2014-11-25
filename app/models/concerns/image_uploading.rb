module ImageUploading
  extend ActiveSupport::Concern

  included do
    dragonfly_accessor :image
  end
end