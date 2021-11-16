# frozen_string_literal: true

require 'pg'

class ActiveUser
  @@user_id = nil
  DATABASE = 'Roma'
  TABLE = 'Users'
  class << self

    def signup(username, password, email)
        connection.exec_params("INSERT INTO #{TABLE} (username,password,email) 
        VALUES ($1,$2,$3) RETURNING ID", [username, password, email])
  
    end

    private

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end
