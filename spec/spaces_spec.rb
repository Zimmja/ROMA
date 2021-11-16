# frozen_string_literal: true

require 'spaces'

describe Space do
  describe '.create' do
    it 'fails if the passed in user ID is nil' do
      expect { Space.create(nil) }.to raise_error 'User not logged in'
    end
  end
end