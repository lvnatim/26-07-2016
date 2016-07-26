class Barracks

  attr_reader :gold, :food

  def initialize
    @gold = 1000
    @food = 80
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

end
