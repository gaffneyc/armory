module Armory
  # Like the GuildFactory this class takes an XML document, or a subset
  # of an XML document, and builds a Character out of it
  class CharacterFactory

    def self.build(doc)
      c = Character.new

      c.name = doc.attr("name")
      c.class_id = doc.attr("classId").to_i
      c.gender_id = doc.attr("genderId").to_i
      c.race_id = doc.attr("raceId").to_i
      c.rank = doc.attr("rank").to_i
      c.level = doc.attr("level").to_i

      c
    end
  end
end
