module Armory
  class Character

    attr_accessor :name, :level, :rank, :guild, :realm, :battle_group,
      :last_modified

    attr_accessor :class_id, :gender_id, :race_id, :faction_id

    def class_name
      Armory::Classes[class_id]
    end

    def gender
      Armory::Genders[gender_id]
    end

    def race
      Armory::Races[race_id]
    end

    def faction
      Armory::Factions[faction_id]
    end

  end
end
