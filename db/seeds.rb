# User
unless User.where(email: 'admin@mystand.ru').any?
  User.create!(email: 'admin@mystand.ru', password: 'beer4stepa')
  puts "User successfully created".colorize(:green)
end

if Settings.count.zero?
  if Settings.create(site_name: { ru: 'Название сайта' }, site_title: { ru: 'Заголовок сайта' }, contact_email: 'mail@site.tld')
    puts "Settings successfully created".colorize(:green)
  end
end