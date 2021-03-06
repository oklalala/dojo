# frozen_string_literal: true

json.extract! post, :id, :title, :content, :photo, :status, :comments_count, :viewed_count, :who_can_see, :created_at, :updated_at
json.url post_url(post, format: :json)
