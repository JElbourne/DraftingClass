json.extract! lesson_link, :id, :lesson_id, :name, :link_url, :created_at, :updated_at
json.url lesson_link_url(lesson_link, format: :json)
