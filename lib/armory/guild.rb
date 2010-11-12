module Armory
  class Guild
    attr_accessor :realm, :name, :faction

    attr_accessor :faction_id

    attr_accessor :characters

    def initialize
      @characters = []
    end

    def faction
      Armory::Factions[faction_id]
    end
  end
end
