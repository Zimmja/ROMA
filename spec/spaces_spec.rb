# frozen_string_literal: true

require 'spaces'
require 'activeuser'

describe Space do
  describe '.create' do
    it 'fails if the passed in user ID is nil' do
      expect { Space.create(nil, "Burrow", '2') }.to raise_error 'User not logged in'
    end

    it 'has added the number of bedrooms' do
      conection = PG.connect(dbname: 'airbnb_test')
      user_id = ActiveUser.signup('Daffy Duck', 'sufferinsuckatash', 'daffy@loony.com')
      expect { Space.create(user_id, "Burrow", '2') }.to change { Space.all.count }.by(1)
    end
  end
end