require 'spec_helper'

describe Armory::Character do
  before(:all) do
    @character = Armory::Character.from_armory(Nokogiri::XML(fixture('hunter')))
  end

  it "should properly parse the base stats" do
    # Basic information
    @character.name.should == 'Hunter'
    @character.level.should == 80
    @character.class_name.should == 'Hunter'
    @character.class_id.should == 3
    @character.guild.should == 'Exiled'
    @character.last_modified.should == Date.parse('2010/10/13')

    # Faction
    @character.faction.should == 'Horde'
    @character.faction_id.should == 1

    # Race
    @character.race.should == 'Orc'
    @character.race_id.should == 2

    # Gender
    @character.gender.should == 'Male'
    @character.gender_id.should == 0

    # Server
    @character.realm.should == 'Detheroc'
    @character.battle_group.should == 'Shadowburn'
  end

  it "should parse the list of items" do
    @character.items.size.should == 18

    # Validate that at least one has parsed correctly
    @character.items.first.tap do |item|
      # Basic information
      item.id.should     == 51286
      item.name.should   == "Sanctified Ahn'Kahar Blood Hunter's Headpiece"
      item.level.should  == 277
      item.slot.should   == 0
      item.rarity.should == 4

      # Enchants, gems, and durability
      item.durability.should     == 99
      item.max_durability.should == 100
      item.enchant_id.should     == 44149
      item.gems.should           == [ 41398, 40112 ]
    end

    # Bounds check with last item in list
    @character.items.last.tap do |item|
      # Basic information
      item.id.should     == 52252
      item.name.should   == "Tabard of the Lightbringer"
      item.level.should  == 80
      item.slot.should   == 18
      item.rarity.should == 4

      # Enchants, gems, and durability
      item.durability.should     == 0
      item.max_durability.should == 0
      item.enchant_id.should     == 0
      item.gems.should           == []
    end
  end
end
