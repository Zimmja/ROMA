# frozen_string_literal: true

require 'pg'

class ActiveUser
  @@user_id = nil
  DATABASE = ''
  TABLE = 'Users'

  class << self

    def signup(username, password, email)
      if DATABASE == ''
        @@user_id = 1
      else
        @@user_id = connection.exec_params("INSERT INTO #{TABLE} (username,password,email) 
      VALUES ($1,$2,$3) RETURNING ID", [username, password, email])
      end
    end

    def id
      @@user_id
    end

    private

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end
