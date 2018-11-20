# -*- coding: utf-8 -*-
require 'faker'

# Create 10 Badges
10.times do

  b = Badge.create!(
    { name: Faker::Number.number(2) + '_' + Faker::Name.unique.name, }
  )
  b.save!

end

puts "seeds 008_badges: Create 10 Badges"
