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

    def self.from_armory(doc)
      Character.new.tap do |char|
        info = doc.css("characterInfo character").first

        char.name  = info.attr("name")
        char.level = info.attr("level").to_i
        char.guild = info.attr("guildName")
        char.realm = info.attr("realm")
        char.battle_group  = info.attr("battleGroup")
        char.last_modified = Date.parse(info.attr('lastModified'))

        # Attribute ids
        char.race_id    = info.attr("raceId").to_i
        char.class_id   = info.attr("classId").to_i
        char.gender_id  = info.attr("genderId").to_i
        char.faction_id = info.attr("factionId").to_i
      end
    end

  end
end
