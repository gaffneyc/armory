require 'nokogiri'
require 'typhoeus'

require 'armory/defines'

module Armory
  extend self

  autoload :VERSION, "armory/version"

  autoload :Guild, "armory/guild"
  autoload :Character, "armory/character"

  autoload :GuildFactory, "armory/guild_factory"
  autoload :CharacterFactory, "armory/character_factory"

  USER_AGENT = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.4) Gecko/20100503 Firefox/3.6.4'

  class Error < Exception; end
  class CharacterNotFound < Error; end
  class GuildNotFound < Error; end

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

    CharacterFactory.build(doc.css("characterInfo character").first)
  end

  def guild_info(region, realm, guild_name)
    response = Typhoeus::Request.get("http://us.wowarmory.com/guild-info.xml", {
      :user_agent => USER_AGENT,
      :params     => { :r => realm, :gn => guild_name }
    })

    case response.code
    when 404
      raise GuildNotFound, "Could not find #{guild_name} on #{region}:#{realm}"
    end

    doc = Nokogiri::XML(response.body)

    GuildFactory.build(doc)
  end
end
