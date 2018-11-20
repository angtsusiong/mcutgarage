# -*- coding: utf-8 -*-
require 'faker'

# Create 6 resource categories
6.times do

  rc = ResourceCategory.create!(
    { name:Faker::Color.color_name, }
  )
  rc.save!

end

puts "seeds 008_resource_categories：Create 6 Resource Categories"
