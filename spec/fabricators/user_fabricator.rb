Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  refresh_token { nil }
end

Fabricator(:google_user, from: :user) do
  refresh_token { ENV["GOOGLE_DRIVE_REFRESH_TOKEN"] }
  google_drive_id { "smashing_good_id"}
end
