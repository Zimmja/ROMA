# frozen_string_literal: true

require 'spaces'
require 'activeuser'

describe Space do
  user_ids = setup_test_tables.user_id_ints

  describe '.create' do
    it 'fails if the passed in user ID is nil' do
      expect { Space.create(nil, 'Stark Tower', '200') }.to raise_error 'User not logged in'
    end

    it 'fails if the passed in user ID is not available' do
      expect { Space.create(1, 'Stark Tower', '250') }.to raise_error 'User not logged in'
    end

    it 'creates a new space if a valid user ID is passed' do
      expect { Space.create(user_ids[0], 'Stark Tower', '300') }.to change { Space.all.count }.by(1)
      expect { Space.create(user_ids[4], 'Asgard', '10000') }.to change { Space.all.count }.by(1)
    end
  end
end