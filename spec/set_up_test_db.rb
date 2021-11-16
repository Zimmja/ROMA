require "pg"

p "Setting up the test db"

def set_test
  connection = PG.connect(dbname: 'airbnb_test')
  connection.exec( "TRUNCATE users;" )
  connection.exec( "TRUNCATE spaces;" )
end