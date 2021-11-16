# frozen_string_literal: true

require 'pg'

# This manages the sign-up process and the properties of the active user
class ActiveUser
  @@user_id = nil

  DATABASE = 'airbnb'
  TABLE = 'users'
  COLUMN0 = 'id'
  COLUMN1 = 'username'
  COLUMN2 = 'password'
  COLUMN3 = 'email'

  class << self

    def signup(username, password, email)
      @@user_id = (create(username, password, email)).first['id']
    end

    def id
      @@user_id
    end

    def username
      return 'none' if @@user_id.nil?
      connection.query("SELECT * FROM #{TABLE} WHERE #{COLUMN0} = #{@@user_id};").first["#{COLUMN1}"]
    end

    private

    def create(user, pword, mail)
      connection.exec_params("INSERT INTO users (username,password,email) 
      VALUES ($1,$2,$3) RETURNING id", [user,pword,mail])
    end

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end
