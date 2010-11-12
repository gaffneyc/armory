require 'date'

module Armory
  class Character

    attr_accessor :name, :level, :guild, :realm, :battle_group, :last_modified
    attr_accessor :class_id, :gender_id, :race_id, :faction_id
    attr_reader :items

    def initialize
      @items = []
    end

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

        doc.css("characterTab items item").each do |item|
          char.items << Item.from_armory(item)
        end
      end
    end

    class Item
      attr_accessor :id, :name, :level, :slot, :rarity
      attr_accessor :durability, :max_durability, :enchant_id
      attr_reader :gems

      def initialize
        @gems = []
      end

      def self.from_armory(doc)
        Item.new.tap do |item|
          item.id     = doc.attr('id').to_i
          item.name   = doc.attr('name')
          item.level  = doc.attr('level').to_i
          item.slot   = doc.attr('slot').to_i
          item.rarity = doc.attr('rarity').to_i

          item.durability     = doc.attr('durability').to_i
          item.max_durability = doc.attr('maxDurability').to_i
          item.enchant_id     = doc.attr('permanentEnchantItemId').to_i

          3.times do |i|
            gem = doc.attr("gem#{i}Id").to_i
            item.gems << gem if gem != 0
          end
        end
      end
    end
  end
end
