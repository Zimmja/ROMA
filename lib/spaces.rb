# frozen_string_literal: true

# Spaces are specific to users
class Space
  @@database_installed = false

  DATABASE = 'airbnb'
  TABLE = 'spaces'
  COLUMN0 = 'id'
  COLUMN1 = 'name'
  COLUMN2 = 'bedrooms'
  COLUMN3 = 'fk_user'

  class << self
    def create(user_id, name, bedrooms)
      fail 'User not logged in' if user_id.nil?
      add_to_table(user_id, name, bedrooms)
    end

    def all
      connection.exec("SELECT * FROM #{TABLE}")
    end

    private

    def add_to_table(user, name, bedrooms)
      return 12 if !@@database_installed
      connection.exec_params("INSERT INTO #{TABLE} (#{COLUMN1},#{COLUMN2},#{COLUMN3}) 
      VALUES ($1,$2,$3) RETURNING #{COLUMN0}", [name,bedrooms,user])
    end

  end
end