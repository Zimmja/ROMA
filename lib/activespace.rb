
class ActiveSpace
  @@details = {}

  class << self
    def set_space(id)
      @@details = {
        :name => find_detail(id, 'name'), 
        :bedrooms => find_detail(id, 'bedrooms'), 
        :id => id, 
        :description => find_detail(id, 'description'),
        :prices_per_night => find_detail(id, 'prices_per_night'),
        :hostname => find_host(id)
      }
    end

    def name
      @@details[:name]
    end

    def bedrooms
      @@details[:bedrooms]
    end

    def description
      @@details[:description]
    end

    def prices_per_night
      @@details[:prices_per_night]
    end

    def id
      @@details[:id]
    end

    def hostname
      @@details[:hostname]
    end

    private

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
  end
end