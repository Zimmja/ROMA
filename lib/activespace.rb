
class ActiveSpace
  @@details = {}

  attr_reader :id, :name, :bedrooms, :description, :prices_per_night, :hostname, :host_id
  def initialize(id)
    @id = id
    @name = find_detail(id, 'name')
    @bedrooms = find_detail(id, 'bedrooms')
    @description = find_detail(id, 'description')
    @prices_per_night = find_detail(id, 'prices_per_night')
    @hostname = find_host(id)
    @host_id = find_detail(id, 'fk_user')
  end

  def find_detail(id, detail)
    # puts "Current ID: #{id}, table IDs: #{connection.query('SELECT * FROM spaces').map { |space| space['id'] }}"
    connection.query("SELECT * FROM spaces WHERE id = #{id};").first["#{detail}"]
  end

  def find_host(id)
    connection.query("SELECT * FROM users WHERE id = #{find_detail(id, 'fk_user')};").first['username']
  end

  def connection
    PG.connect(dbname: "airbnb#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
  end

  @@space_id = nil

  class << self
    def set_space(id)
      @@space_id = id
    end

    def id
      @@space_id
    end

    def book_space(space_id, user_id, host_id, start_date, nights)
      connection.exec_params("INSERT INTO bookings (space_id, user_id, host_id, start_date, nights) values($1,$2,$3,$4,$5) RETURNING id;",
      [space_id, user_id, host_id, start_date, nights])
    end

    def connection
      PG.connect(dbname: "airbnb#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end