require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "1a60ea0f5ba90473f7e683da7312939caed06289506b0df74fe6dcaabc8aa1dc"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')

  # processors
  processor :large do |content|
    content.process!(:convert, "-resize '1052x350^' -gravity center")
    content.process!(:encode, 'png')
  end

  processor :medium do |content|
    content.process!(:convert, "-resize '200x150!' -gravity center")
    content.process!(:encode, 'png')
  end

  processor :small do |content|
    content.process!(:convert, "-resize 'x130^' -gravity center -crop '130x130+0+0'")
    content.process!(:encode, 'png')
  end

  processor :logo do |content|
    content.process!(:convert, "-resize 'x50^' -gravity center")
    content.process!(:encode, 'png')
  end

end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end