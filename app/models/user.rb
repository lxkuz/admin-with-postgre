class User < ActiveRecord::Base
  include Searchable

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable,
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :rememberable, :trackable, :validatable

  # Search settings
  settings index: {} do
    mappings dynamic: 'false' do
      indexes :email
    end
  end
end