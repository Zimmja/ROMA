# frozen_string_literal: true

require 'activeuser'

describe ActiveUser do
  describe '.signup' do
    it '@@user_id is set to the ID of a newly-created user' do
      id_value = ActiveUser.signup('Bugs Bunny', 'carrot7', 'whatsupdoc@gmail.com')
      expect(ActiveUser.id).to eq id_value
    end
  end
end
