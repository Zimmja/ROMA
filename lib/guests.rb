class Guest
  @@guest_id = nil

  DATABASE = 'airbnb'

  class << self

    def signup(username, password, email)
      login((create(username, password, email)).first['id'])
    end

    def id
      @@guest_id
    end

    def request_login(username = nil, password = nil)
      return false if (username.nil? || password.nil?)
      guest_id = find_user_id(username, password)
      guest_id.to_i < 0 ? false : login(guest_id)
    end

    def logout
      @@user_id = nil
    end

    def login(guest_id)
      @@guest_id = guest_id
    end

    def username
      return 'none' if @@guest_id.nil?
      connection.query("SELECT * FROM users WHERE id = #{@@guest_id};").first['username']
    end

    private

    def find_user_id(username, password)
      user_row = connection.query("SELECT * FROM users WHERE username = '#{username}' AND password = '#{password}';").first
      user_row.nil? ? -1 : user_row['id']
    end

    def create(user, pword, mail)
      connection.exec_params("INSERT INTO users (username,password,email) VALUES ($1,$2,$3) RETURNING id", [user,pword,mail])
    end

    def connection
      PG.connect(dbname: "#{DATABASE}#{'_test' if ENV['ENVIRONMENT'] == 'test'}")
    end
  end
end
