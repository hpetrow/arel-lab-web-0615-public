class Captain < ActiveRecord::Base
  has_many :boats

  def table
    self.joins(:boats => :classifications)
  end

  def self.catamaran_operators
    self.joins(:boats => :classifications)
    .where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    self.joins(:boats => :classifications).group("captains.id")
    .where(:classifications => {:name => "Sailboat"}) 
  end

  def self.motorboat_operators
    self.joins(:boats => :classifications).group("captains.id")
    .where(:classifications => {:name => "Motorboat"}) 
  end

  def self.talented_seamen
    self.motorboat_operators.where("captains.id in (?)", self.sailors.pluck(:id))
  end

  def self.non_sailors
    self.where("captains.id not in (?)", self.sailors.pluck(:id))
  end
end
