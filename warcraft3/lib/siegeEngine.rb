class SiegeEngine < Unit

  def initialize
    super(400, 50)
  end

    def attack!(target)
    modifier = 1
    modifier = 2 if target.class == Barracks
    if target.is_a? Unit
      return nil unless target.is_a? SiegeEngine
    end
    target.damage(attack_power*modifier) unless dead? || target.dead?
  end

end