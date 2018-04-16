# frozen_string_literal: true

# rubocop
module ApplicationHelper
  def active_class?(path)
    return 'active' if current_page?(path)
  end
end
