class Attachment < ActiveRecord::Base
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  validates :file, presence: true

  dragonfly_accessor :file
  
  belongs_to :target, polymorphic: true
end
