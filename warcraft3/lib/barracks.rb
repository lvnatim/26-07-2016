class Barracks

  attr_reader :gold, :food, :health_points, :lumber

  def initialize
    @health_points = 500
    @gold = 1000
    @food = 80
    @lumber = 500
  end

  def can_train_footman?
    return false if gold < 135
    return false if food < 2
    true
  end

  def train_footman
    if can_train_footman?
      @gold -= 135
      @food -= 2
      Footman.new
    end
  end

  def can_train_peasant?
    return false if gold < 90
    return false if food < 5
    true
  end

  def train_peasant
    if can_train_peasant?
      @gold -= 90
      @food -= 5
      Peasant.new
    end
  end

  def can_train_siege_engine?
    return false if gold < 200
    return false if lumber < 60
    return false if food < 3
    true
  end

  def train_siege_engine
    if can_train_siege_engine?
      @gold -= 200
      @lumber -= 60
      @food -= 3
      SiegeEngine.new
    end
  end

  def damage(damage)
    @health_points -= damage
  end

  def dead?
    return true if health_points <= 0
    false
  end

end
