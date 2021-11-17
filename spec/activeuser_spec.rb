# frozen_string_literal: true

require 'activeuser'

describe ActiveUser do
  describe '.signup' do
    it '@@user_id is set to the ID of a newly-created user' do
      id_value = ActiveUser.signup('Peter Parker', 'spiderman', 'parker@gmail.com')
      expect(ActiveUser.id).to eq id_value
    end
  end

  describe '.logout' do
    it 'sets @@user_id to nil' do
      ActiveUser.logout
      expect(ActiveUser.id).to eq nil
    end
  end

  describe '.request_login' do
    it 'prevents login if no username or password are provided' do
      expect(ActiveUser.request_login).to eq false
    end

    it 'prevents login if incorrect username and password are provided' do
      expect(ActiveUser.request_login('Bruce Wayne','batman')).to eq false
    end

    it 'allows login with correct details' do
      expect(ActiveUser.request_login('Tony Stark','ironman')).not_to eq false
    end
  end
end
