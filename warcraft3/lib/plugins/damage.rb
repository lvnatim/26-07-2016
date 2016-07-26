module Damage
  def damage(ap)
    damage = ap
    if self.class == Barracks
      damage *= 0.5
      damage = damage.ceil
    end
    self.health_points -= damage
  end

end