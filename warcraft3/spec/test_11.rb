require_relative 'spec_helper'

describe Barracks do

  describe '#new' do

    it 'should have health points' do
      barracks = Barracks.new
      expect(barracks.health_points).to eq(500)
    end

    it 'should have a food attribute and a gold attribute' do
      barracks = Barracks.new
      expect(barracks.food).not_to be_nil
      expect(barracks.gold).not_to be_nil
    end

  end

  describe '#damage' do

    it 'should be able to take damage' do
      barracks = Barracks.new
      expect(barracks.damage(20)).to eq(480)
    end

    it 'only takes half damage from attacks' do
      barracks = Barracks.new
      footman = Footman.new
      expect(footman.attack!(barracks)).to eq(495)
    end

    it 'should round damage up from attacks' do
      barracks = Barracks.new
      footman = Footman.new
      footman.should_receive(:attack_power).at_least(1).times.and_return(11)
      expect(footman.attack!(barracks)).to eq(494)
    end

  end

  describe "#can_train_siege_engine?" do

    it "should return true if there are enough resources" do
      barracks = Barracks.new
      footman = Footman
      expect(barracks.can_train_siege_engine?).to eq(true)
    end

    it "should return false if there are not enough resources" do
      barracks = Barracks.new
      barracks.should_receive(:lumber).at_least(1).times.and_return(5)
      expect(barracks.can_train_siege_engine?).to eq(false)
    end

  end

  describe '#train_siege_engine' do

    it "should train siege engine if there are enough resources" do
      barracks = Barracks.new
      expect(barracks.train_siege_engine).to be_a SiegeEngine
      expect(barracks.gold).to eq(800)
      expect(barracks.food).to eq(77)
      expect(barracks.lumber).to eq(440)
    end

    it "should not train siege engines if there aren't enough resources" do
      barracks = Barracks.new
      barracks.should_receive(:can_train_siege_engine?).at_least(1).times.and_return(false)
      expect(barracks.train_siege_engine).to be_nil
    end

  end

end

describe Unit do 

  describe "#attack" do

    it 'should be able to attack barracks' do
      barracks = Barracks.new
      footman = Footman.new
      expect(footman.attack!(barracks)).to eq(495)
      expect(footman.attack!(barracks)).to eq(490)
    end

    it 'should not be able to attack a dead unit' do
      footman = Footman.new
      dead_footman = Footman.new
      dead_footman.health_points = -15
      expect(footman.attack!(dead_footman)).to be_nil
    end

    it 'should not be able to attack if dead' do
      footman = Footman.new
      dead_footman = Footman.new
      dead_footman.health_points = 0
      expect(dead_footman.attack!(footman)).to be_nil
    end 

  end

  describe "#damage" do

    it 'should take full damage from attacks' do
      footman = Footman.new
      expect(footman.damage(50)).to eq(10)
    end

  end

  describe "#dead?" do

    it 'should return true if the unit has <= 0 health points.' do
      footman = Footman.new
      footman.health_points = 0
      expect(footman.dead?).to eq(true)
    end

    it 'should return false if the unit has > 0 health points.' do
      footman = Footman.new
      footman.health_points = 20
      expect(footman.dead?).to eq(false)
    end

  end

end

describe SiegeEngine do

  describe "#new" do

    it "should have health points and attack power" do
      unit = SiegeEngine.new
      expect(unit.health_points).not_to be_nil
      expect(unit.attack_power).not_to be_nil
    end

  end

  describe "#attack!" do

    it "should do double damage to barracks" do
      barracks = Barracks.new
      unit = SiegeEngine.new
      expect(unit.attack!(barracks)).to eq(400)
    end

    it "can only attack other units if they are instances of the SiegeEngine class" do
      footman = Footman.new
      peasant = Peasant.new
      another_engine = SiegeEngine.new
      unit = SiegeEngine.new
      expect(unit.attack!(footman)).to be_nil
      expect(unit.attack!(peasant)).to be_nil
      expect(unit.attack!(another_engine)).to eq(350)
    end

  end

end