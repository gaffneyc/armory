module Armory
  class Guild
    attr_accessor :name, :realm, :faction_id, :characters

    def initialize
      @characters = []
    end

    def faction
      Armory::Factions[faction_id]
    end

    def self.from_armory(doc)
      Guild.new.tap do |guild|
        info   = doc.css("guildInfo")
        header = info.css("guildHeader")

        guild.name       = header.attr("name").value
        guild.realm      = header.attr("realm").value
        guild.faction_id = header.attr("faction").value.to_i

        info.css("guild members character").each do |member|
          guild.characters << Armory::Guild::Character.new(
            member.attr('name'),
            member.attr('rank').to_i,
            member.attr('level').to_i,
            member.attr('classId').to_i,
            member.attr('genderId').to_i,
            member.attr('raceId').to_i
          )
        end
      end
    end

    class Character < Struct.new(:name, :rank, :level, :class_id, :gender_id, :race_id)
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
end
