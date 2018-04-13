# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test 'visiting the index' do
    visit posts_url
    assert_selector 'h1', text: 'Posts'
  end

  test 'creating a Post' do
    visit posts_url
    click_on 'New Post'

    fill_in 'Content', with: @post.content
    fill_in 'Photo', with: @post.photo
    fill_in 'Comments Count', with: @post.comments_count
    fill_in 'Status', with: @post.status
    fill_in 'Title', with: @post.title
    fill_in 'Viewed Count', with: @post.viewed_count
    fill_in 'Who Can See', with: @post.who_can_see
    click_on 'Create Post'

    assert_text 'Post was successfully created'
    click_on 'Back'
  end

  test 'updating a Post' do
    visit posts_url
    click_on 'Edit', match: :first

    fill_in 'Content', with: @post.content
    fill_in 'Photo', with: @post.photo
    fill_in 'Comments Count', with: @post.comments_count
    fill_in 'Status', with: @post.status
    fill_in 'Title', with: @post.title
    fill_in 'Viewed Count', with: @post.viewed_count
    fill_in 'Who Can See', with: @post.who_can_see
    click_on 'Update Post'

    assert_text 'Post was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Post' do
    visit posts_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Post was successfully destroyed'
  end
end
