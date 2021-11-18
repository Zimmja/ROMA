require "pg"

def setup_test_tables
  TestSetup.new
end

# I've set up the tests this way so that when new users are created, their generated IDs
# are stored in an array. We can then access this array for ID values when running tests in rspec
class TestSetup
  attr_reader :user_id_ints
  def initialize
    @user_id_ints = []
    setup_users
    setup_spaces
    puts print "User IDs added: #{@user_id_ints}"
    puts
  end

  #-------------------------------------
  # SET UP SPACES
  #-------------------------------------
  def setup_spaces
    populate_space_table(space_vals)
  end

  def populate_space_table(values)
    values.each do |space|
      user_row = connection.exec_params("INSERT INTO spaces (name, bedrooms, fk_user, description, prices_per_night) values($1,$2,$3,$4,$5) RETURNING id;",
      [space[:name],space[:bedrooms],space[:fk_user],space[:description],space[:prices_per_night]]) # Broken over two lines to ease readability
    end
  end

  def space_vals
    [ { :name => 'Stark Mansion', :bedrooms => '8', :fk_user => @user_id_ints[0], 
      :description => "A mansion", :prices_per_night => '$50000' },
      { :name => 'New Avengers', :bedrooms => '50', :fk_user => @user_id_ints[1], 
        :description => 'Training', :prices_per_night => '$120' },
      { :name => 'Trailer', :bedrooms => '1', :fk_user => @user_id_ints[2], 
        :description => 'Very private', :prices_per_night => '$70' }, ]
  end

  #-------------------------------------
  # SET UP USERS
  #-------------------------------------
  def setup_users
    puts
    puts "Setting up test tables for #{db_name} database: #{connection}"
    connection.exec( "TRUNCATE users CASCADE; TRUNCATE spaces" )
    populate_users_table(users_vals)
  end

  def populate_users_table(values)
    values.each do |user|
      user_row = connection.exec_params("INSERT INTO users (username, password, email) values($1,$2,$3) RETURNING id;",
      [user[:username],user[:password],user[:email]]) # Broken over two lines to ease readability
      @user_id_ints << user_row.first['id']
    end
  end

  def users_vals
    [ { :username => 'Tony Stark', :password => 'ironman', :email => 'tony@stark.com' },
      { :username => 'Steve Rogers', :password => 'captainamerica', :email => 'rogers@yahoo.com' },
      { :username => 'Natasha Romanoff', :password => 'blackwidow', :email => 'nat@gmail.com' },
      { :username => 'Bruce Banner', :password => 'hulk', :email => 'hulk@smash.com' },
      { :username => 'Thor Odinson', :password => 'thor', :email => 'bestavenger@asgard.com' } ]
  end

  def db_name
    "airbnb#{'_test' if ENV['ENVIRONMENT'] == 'test'}"
  end

  def connection
    PG.connect(dbname: db_name)
  end
end
