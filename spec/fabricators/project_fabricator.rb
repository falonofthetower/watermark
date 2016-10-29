Fabricator(:project) do
  name { Faker::Name.name }
  google_drive_id { Faker::Name.name }
end
