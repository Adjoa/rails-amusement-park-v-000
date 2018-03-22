class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction
  
  def take_ride
    if not_enough_tickets? && too_short?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif not_enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif too_short?
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    else
      xtickets = self.user.tickets -= self.attraction.tickets
      xnausea = self.user.nausea += self.attraction.nausea_rating
      xhappiness = self.user.happiness += self.attraction.happiness_rating
      self.user.update(tickets: xtickets, nausea: xnausea, happiness: xhappiness)
    end
  end
  
  def not_enough_tickets?
    self.user.tickets < self.attraction.tickets
  end
  
  def too_short? 
    self.user.height < self.attraction.min_height
  end
end
