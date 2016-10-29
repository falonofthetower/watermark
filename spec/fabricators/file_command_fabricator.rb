Fabricator(:file_command) do
  title { Faker::Lorem.word }
  mime_type { "text/plain" }
  parents { [] }
  upload_source { nil }
  content_type { nil }
end
