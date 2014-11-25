class Settings < ActiveRecord::Base
  multilang :site_name, :site_title

  dragonfly_accessor :logo
end
