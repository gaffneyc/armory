require 'spec_helper'

describe Armory do
  # TODO: Handle title
  # TODO: Handle skills
  # TODO: Handle equipment
  # TODO: Make a Character model instead of some crazy hash
  it "should properly parse a character" do
    response = mock(
      :body => fixture("hunter")
    )
    Typhoeus::Request.expects(:get).returns(response)
    
    result = Armory.character_sheet('us', 'detheroc', 'hunter')

    # Basic information
    result[:name].should == 'Hunter'
    result[:level].should == 80
    result[:class].should == 'Hunter'
    result[:class_id].should == 3
    result[:guild].should == 'Exiled'
    result[:last_modified].should == Date.parse('2010/10/13')

    # Faction
    result[:faction].should == 'Horde'
    result[:faction_id].should == 1

    # Race
    result[:race].should == 'Orc'
    result[:race_id].should == 2

    # Gender
    result[:gender].should == 'Male'
    result[:gender_id].should == 0

    # Server
    result[:realm].should == 'Detheroc'
    result[:region].should == 'us'
    result[:battle_group].should == 'Shadowburn'
  end

  xit "should raise appropriate errors if the armory is not available"
  xit "should raise appropriate errors if the rate limit has been reached"
  xit "should raise appropriate errors if the character cannot be found"
end
