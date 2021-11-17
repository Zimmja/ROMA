require "pg"

def setup_test_tables
  TestSetup.new
end

class TestSetup
  attr_reader :user_id_ints
  def initialize
    @user_id_ints = []
    setup_tables
    puts print "User IDs added: #{@user_id_ints}"
    puts
  end

  def setup_tables
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
