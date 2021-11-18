# frozen_string_literal: true

require 'spaces'
require 'activeuser'

describe Space do
  connection = PG.connect(dbname: "airbnb#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
  user_ids = connection.query('SELECT id FROM users').map { |row| row['id']}

  describe '.create' do
    it 'fails if the passed in user ID is nil' do
      expect { Space.create(nil, 'Stark Tower', '200', 
        'Highrise in central Manhatten', '$2000') }.to raise_error 'User not logged in'
    end

    it 'fails if the passed in user ID is not available' do
      expect { Space.create(1, 'Stark Tower', '250', 
        'Highrise in central Manhatten', '$2000') }.to raise_error 'User not logged in'
    end

    it 'creates a new space if a valid user ID is passed' do
      ActiveUser.request_login('Tony Stark', 'ironman')
      expect { Space.create(user_ids[0], 'Stark Tower', '300', 
        'Highrise in central Manhatten', '$2000') }.to change { Space.all.count }.by(1)
    end
  end
end