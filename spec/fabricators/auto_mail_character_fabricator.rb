Fabricator(:auto_mail_character) do
  user!
  name { Faker::Lorem.sentence(1).gsub(/\s+/, '') }
end
