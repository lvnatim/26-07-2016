# http://classic.battle.net/war3/human/units/footman.shtml

class Footman < Unit

  def initialize
    super(60, 10)
  end

  def attack!(enemy)
    enemy.damage(attack_power)
  end

end
