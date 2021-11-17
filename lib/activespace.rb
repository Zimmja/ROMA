
class ActiveSpace
  @@details = {}

  # This needs to be redone to only accept an ID number for a space
  class << self
    def set_space(name, bedrooms, id, hostname)
      @@details = {:name => name, :bedrooms => bedrooms, :id => id, :hostname => hostname}
    end

    def name
      @@details[:name]
    end

    def bedrooms
      @@details[:bedrooms]
    end

    def id
      @@details[:id]
    end

    def hostname
      @@details[:hostname]
    end
  end
end