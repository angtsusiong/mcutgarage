# -*- coding: utf-8 -*-
require 'faker'

# Load pending projects
pending_projects = Project.includes(:projects_users).where( status: 'pending')

pending_projects.each do |p|
  # Each Project have random number of members between 1 to 8.
  number_of_examiner = Faker::Number.between(0,4).to_i

  # Randomly choose a leader
  the_examiner = User.find_by(id: Faker::Number.between(21,70))
  p.projects_users.create({
    user_id: the_examiner.id,
    typing: 'the_examiner'})

  if number_of_examiner > 0
    examiners_list = (21..70).to_a
    examiners_list.delete(the_examiner.id)
    number_of_examiner.times do
      add_user_id = examiners_list.sample
      p.projects_users.create({
        user_id: add_user_id,
        typing: 'examiner'})
      examiners_list.delete(add_user_id)
    end
  end # end of if

  p.status='examining'
  p.save
end # end of all projects

puts "seeds 012_assign_examiners：Assign Examiners to Pending Projects "
