# frozen_string_literal: true

require 'activespace'

describe ActiveSpace do
  connection = PG.connect(dbname: "airbnb#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
  user_ids = connection.query('SELECT id FROM spaces').map { |row| row['id']}
  mansion_id = user_ids.first

  let(:testspace) { ActiveSpace.new(mansion_id) }

  describe '.set_space' do
    it 'Sets the ActiveUser with new values' do
      expect(testspace.name).to eq 'Stark Mansion'
      expect(testspace.bedrooms).to eq '8'
      expect(testspace.id).to eq mansion_id
      expect(testspace.description).to eq 'A mansion'
      expect(testspace.prices_per_night).to eq '$50000'
      expect(testspace.hostname).to eq 'Tony Stark'
    end
  end
end