require "pry"

User.destroy_all
Restaurant.destroy_all
Review.destroy_all


david = User.create(name: "David")

wework = Restaurant.create(name: "Flatiron School", rating:"5", address:"2420 17th St, Denver, CO 80202")
