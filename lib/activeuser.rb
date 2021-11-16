# frozen_string_literal: true

require 'pg'

# This manages the sign-up process and the properties of the active user
class ActiveUser
  @@user_id = nil
  @@database_installed = false

  DATABASE = 'Roma'
  TABLE = 'Users'
  COLUMN0 = 'ID'
  COLUMN1 = 'username'
  COLUMN2 = 'password'
  COLUMN3 = 'email'

  class << self

    def signup(username, password, email)
      if @@database_installed
        @@user_id = create(username, password, email)
      else
        @@user_id = 1
      end
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
      connection.exec_params("INSERT INTO #{TABLE} (#{COLUMN1},#{COLUMN2},#{COLUMN3}) 
      VALUES ($1,$2,$3) RETURNING #{COLUMN0}", [user,pword,mail])
    end

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end
