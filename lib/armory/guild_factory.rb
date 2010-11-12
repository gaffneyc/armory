module Armory
  # Takes in XML for guild information and converts it
  # into a Guild object with a list of Characters
  class GuildFactory

    def self.build(doc)
      g = Guild.new

      info = doc.css("guildInfo")
      header = info.css("guildHeader")
      guild = info.css("guild")

      g.name = header.attr("name").value
      g.realm = header.attr("realm").value
      g.faction_id = header.attr("faction").value.to_i

      guild.css("members character").each do |member|
        g.characters << CharacterFactory.build(member)
      end

      g
    end

  end
end
