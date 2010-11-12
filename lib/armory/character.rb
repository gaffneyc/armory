module Armory
  class Character

    attr_accessor :name, :klass, :race, :level, :gender, :rank, :faction, :guild,
      :realm, :battle_group, :last_modified

    attr_accessor :klass_id, :gender_id, :race_id, :faction_id

    def class_id=(val)
      @klass = Class[val]
      @klass_id = val
    end

    def gender_id=(val)
      @gender = Gender[val]
      @gender_id = val
    end

    def race_id=(val)
      @race = Race[val]
      @race_id = val
    end

    def faction_id=(val)
      @faction = Faction[val]
      @faction_id = val
    end

  end
end
