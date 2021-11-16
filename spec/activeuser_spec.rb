# frozen_string_literal: true

require 'activeuser'

describe ActiveUser do
  describe '.signup' do
    it 'adds a new user to the users table' do
      expect(ActiveUser.signup.class).to eq ActiveUser
    end
  end
end
