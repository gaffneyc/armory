require 'nokogiri'
require 'typhoeus'
require 'armory/version'

module Armory
  extend self

  USER_AGENT = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.4) Gecko/20100503 Firefox/3.6.4'

  class Error < Exception; end
  class CharacterNotFound < Error; end

  # TODO: Validate realms
  # TODO: Handle different regions
  # http://us.wowarmory.com/character-sheet.xml?r=Detheroc&n=Hunter
  def character_sheet(region, realm, character)
    response = Typhoeus::Request.get("http://us.wowarmory.com/character-sheet.xml", {
      :user_agent => USER_AGENT,
      :params     => { :r => realm, :n => character }
    })

    case response.code
    when 404
      raise CharacterNotFound, "Could not find #{character} on #{region}:#{realm}"
    end

    doc = Nokogiri::XML(response.body)
    char_info = doc.css("characterInfo character")

    {
      :name       => char_info.attr('name').value,
      :level      => char_info.attr('level').value.to_i,
      :guild      => char_info.attr('guildName').value,

      :region     => region,
      :realm      => char_info.attr('realm').value,
      :battle_group  => char_info.attr('battleGroup').value,
      :last_modified => Date.parse(char_info.attr('lastModified').value),

      :class      => char_info.attr('class').value,
      :class_id   => char_info.attr('classId').value.to_i,

      :faction    => char_info.attr('faction').value,
      :faction_id => char_info.attr('factionId').value.to_i,

      :race       => char_info.attr('race').value,
      :race_id    => char_info.attr('raceId').value.to_i,

      :gender     => char_info.attr('gender').value,
      :gender_id  => char_info.attr('genderId').value.to_i
    }
  end

  def guild_info(region, realm, guild_name)
    response = Typhoeus::Request.get("http://us.wowarmory.com/guild-info.xml", {
      :user_agent => USER_AGENT,
      :params     => { :r => realm, :gn => guild_name }
    })

    case response.code
    when 404
      raise CharacterNotFound, "Could not find #{character} on #{region}:#{realm}"
    end

    doc = Nokogiri::XML(response.body)

    info = doc.css("guildInfo")
    header = info.css("guildHeader")
    guild = info.css("guild")

    {
      :name => header.attr("name").value,
      :realm => header.attr("realm").value,
      :faction_id => header.attr("faction").value.to_i,

      :characters => guild.css("members character").map do |member|
        {
          :name => member.attr("name"),
          :class_id => member.attr("classId").to_i,
          :gender_id => member.attr("genderId").to_i,
          :race_id => member.attr("raceId").to_i,
          :level => member.attr("level").to_i
        }
      end
    }
  end
end
