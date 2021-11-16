# frozen_string_literal: true

require 'spaces'

describe Space do
  describe '.create' do
    it 'fails if the passed in user ID is nil' do
      expect { Space.create(nil, nil, nil) }.to raise_error 'User not logged in'
    end

    it 'returns the ID value of the new space' do
      expect(Space.create(8, "Burrow", 2)).to eq 12
    end
  end
end