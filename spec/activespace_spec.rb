# frozen_string_literal: true

require 'activespace'

describe ActiveSpace do
  connection = PG.connect(dbname: "airbnb#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
  user_ids = connection.query('SELECT id FROM spaces').map { |row| row['id']}
  mansion_id = user_ids.first

  describe '.set_space' do
    it 'Sets the ActiveUser with new values' do
      ActiveSpace.set_space(mansion_id)
      expect(ActiveSpace.name).to eq 'Stark Mansion'
      expect(ActiveSpace.bedrooms).to eq '8'
      expect(ActiveSpace.id).to eq mansion_id
      expect(ActiveSpace.description).to eq 'A mansion'
      expect(ActiveSpace.prices_per_night).to eq '$50000'
      expect(ActiveSpace.hostname).to eq 'Tony Stark'
    end
  end
end