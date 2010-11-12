module Armory
  class Guild
    attr_accessor :realm, :name, :faction

    attr_accessor :faction_id

    attr_accessor :characters

    def initialize
      @characters = []
    end

    def faction_id=(val)
      @faction = Faction[val]
      @faction_id = val
    end
  end
end
