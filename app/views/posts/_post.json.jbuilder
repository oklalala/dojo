# frozen_string_literal: true

json.extract! post, :id, :title, :contant, :photo, :status, :replies_count, :viewed_count, :who_can_see, :created_at, :updated_at
json.url post_url(post, format: :json)
