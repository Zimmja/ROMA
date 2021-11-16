# frozen_string_literal: true

class Space
  DATABASE = ''
  TABLE = 'Spaces'

  class << self
    def create(user_id, name, bedrooms)
      fail 'User not logged in' if user_id.nil?
      create(user_id, name, bedrooms)
    end

    private

    

  end
end