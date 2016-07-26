class Unit

  attr_reader :attack_power
  attr_accessor :health_points

  def initialize(hp, ap)
    @health_points = hp
    @attack_power = ap
  end

  def attack!(target)
    modifier = 1
    modifier = 0.5 if target.is_a? Barracks
    target.damage((attack_power*modifier).ceil) unless dead? || target.dead?
  end

  def dead?
    return true if health_points <= 0
    false
  end

  def damage(damage)
    @health_points -= damage
  end

end