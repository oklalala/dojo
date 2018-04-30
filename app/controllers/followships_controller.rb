# frozen_string_literal: true

class FollowshipsController < ApplicationController

  scope :accept, -> { where(accept: true) }
  
end
