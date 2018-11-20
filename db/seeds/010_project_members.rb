# -*- coding: utf-8 -*-
require 'faker'

# Load all projects
all_project = Project.includes(:projects_users).all

all_project.each do |p|
  # Each Project have random number of members between 1 to 8.
  number_of_members = (1..8).to_a.sample.to_i

  # Randomly choose a leader
  team_leader_id = (91..140).to_a.sample.to_i

  # Available members that can join to this project
  member_list = (91..140).to_a
  member_list.delete(team_leader_id)

  number_of_members.times do
    # Add leader to this project first
    if p.projects_users.empty?
      p.projects_users.create({
        project_id: p.id,
        user_id: team_leader_id,
        typing: 'leader'
      })

    # Add else members to this project
    elsif
      add_user_id = member_list.sample.to_i
      p.projects_users.create({
        project_id: p.id,
        user_id: add_user_id,
        typing: 'member'
      })
      # Remove the member we just add to this project form member_list
      member_list.delete(add_user_id)
    end # end if
  end # end of add members to a project
end # end of all projects

puts "seeds 010_project_members：Add leader and members to projects"
