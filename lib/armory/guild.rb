module Armory
  class Guild
    attr_accessor :realm, :name, :faction

    attr_accessor :characters

    def initialize
      @characters = []
    end

    def faction_id=(val)
      @faction = Faction[val]
    end
  end
end
