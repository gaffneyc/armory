module Armory
  # Like the GuildFactory this class takes an XML document, or a subset
  # of an XML document, and builds a Character out of it
  class CharacterFactory

    def self.build(doc)
      c = Character.new

      c.name = doc.attr("name")

      c.level = doc.attr("level").to_i

      c.class_id = doc.attr("classId").to_i
      c.gender_id = doc.attr("genderId").to_i
      c.race_id = doc.attr("raceId").to_i

      c.rank = doc.attr("rank").to_i

      if doc.attr("guildName")
        c.guild = doc.attr("guildName")

        c.realm = doc.attr("realm")
        c.battle_group = doc.attr("battleGroup")

        c.level = doc.attr("level").to_i

        c.last_modified = Date.parse(doc.attr('lastModified'))

        c.faction_id = doc.attr("factionId").to_i
      end

      c
    end
  end
end
