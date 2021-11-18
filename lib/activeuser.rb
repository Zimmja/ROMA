# frozen_string_literal: true

require 'pg'

# This manages the sign-up process and the properties of the active user
class ActiveUser
  @@user_id = nil

  DATABASE = 'airbnb'

  class << self

    def signup(username, password, email)
      login((create(username, password, email)).first['id'])
    end

    def id
      @@user_id
    end

    def request_login(username = nil, password = nil)
      return false if (username.nil? || password.nil?)
      user_id = find_user_id(username, password)
      user_id.to_i < 0 ? false : login(user_id)
    end

    def logout
      @@user_id = nil
    end

    def login(user_id)
      @@user_id = user_id
    end

    def username
      return 'none' if @@user_id.nil?
      connection.exec("SELECT * FROM users WHERE id = #{@@user_id};").first['username']
    end

    private

    def find_user_id(username, password)
      user_row = connection.query("SELECT * FROM users WHERE username = '#{username}' AND password = '#{password}';").first
      user_row.nil? ? -1 : user_row['id']
    end

    def create(user, pword, mail)
      connection.exec_params("INSERT INTO users (username,password,email) VALUES ($1,$2,$3) RETURNING id", [user,pword,mail])
    end

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end
