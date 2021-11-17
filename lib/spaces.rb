# frozen_string_literal: true

# Spaces are specific to users
class Space

  DATABASE = 'airbnb'

  

  attr_reader :name, :bedrooms, :hostname, :description, :prices_per_night
  def initialize(name, bedrooms, hostname, description, prices_per_night)
    @name = name
    @bedrooms = bedrooms
    @hostname = hostname
    @descrition = description
    @price_per_night = prices_per_night
  end

  class << self
    def create(user_id, name, bedrooms, description, prices_per_night)
      fail 'User not logged in' if user_id.nil?
      add_to_table(user_id, name, bedrooms, description, prices_per_night)
    end

    def all_objects
      all.map { |space| create_object(space) }
    end

    def all
      connection.exec('SELECT * FROM spaces')
    end

    def create_object(space)
      Space.new(space['name'], space['bedrooms'], find_owner_username(space['fk_user']), space['description'], space['prices_per_night'])
    end

    def find_owner_username(host_id)
      connection.query("SELECT * FROM users WHERE id = #{host_id};").first['username']
    end

    private

    def add_to_table(user_id, name, bedrooms, description, prices_per_night)
      connection.exec_params("INSERT INTO spaces (name,bedrooms,fk_user,description,prices_per_night) 
      VALUES ($1,$2,$3,$4,$5) RETURNING id", [name,bedrooms,user_id,description,prices_per_night])
    end

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end


  