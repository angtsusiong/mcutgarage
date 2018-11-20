# -*- coding: utf-8 -*-
categories = [
  { name: Faker::Nation.nationality, brief_intro: Faker::Food.description, is_active: Faker::Boolean.boolean(0.8)},
  { name: Faker::Nation.nationality, brief_intro: Faker::Food.description, is_active: Faker::Boolean.boolean(0.8)},
  { name: Faker::Nation.nationality, brief_intro: Faker::Food.description, is_active: Faker::Boolean.boolean(0.8)},
  { name: Faker::Nation.nationality, brief_intro: Faker::Food.description, is_active: Faker::Boolean.boolean(0.8)},
  { name: Faker::Nation.nationality, brief_intro: Faker::Food.description, is_active: Faker::Boolean.boolean(0.8)},
  { name: Faker::Nation.nationality, brief_intro: Faker::Food.description, is_active: Faker::Boolean.boolean(0.8)},
]

categories.each do | c |
  pc = ProjectCategory.create!(
    {
      name: c[:name],
      brief_intro: c[:brief_intro],
      is_active: c[:is_active],
    }
  )
  pc.save!
end

puts "seeds 004_project_categories: Create 6 Project Categories"
