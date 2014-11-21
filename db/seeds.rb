unless User.where(email: 'admin@mystand.ru').any?
  User.create!(email: 'admin@mystand.ru', password: 'beer4stepa')
end
