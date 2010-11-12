module Armory
  class Character

    attr_accessor :name, :klass, :race, :level, :gender, :rank

    def class_id=(val)
      @klass = Class[val]
    end

    def gender_id=(val)
      @gender = Gender[val]
    end

    def race_id=(val)
      @race = Race[val]
    end

  end
end
