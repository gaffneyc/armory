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
end
