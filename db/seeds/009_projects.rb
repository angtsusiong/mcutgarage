# -*- coding: utf-8 -*-
require 'faker'
require 'news-api'
@url="https://newsapi.org/v2/top-headlines?country=tw&apiKey=14426f14e7a3432bac878ebc105f4e2b"
@projs = JSON(RestClient.get(@url).body)['articles']

@act = Activity.first

# Create 20 Projects
@projs.each do |ps|

  @pro = Project.new({
    name: ps.values_at('title').to_sentence,
    project_category_id: (1..6).to_a.sample.to_i, # Randomly choose project category
    activity_id: @act.id,
    status: [0,1].sample.to_i })
  @pro.save
  puts @pro.name
  @act.steps.each do |st|
    st.requirements.each do |req|
      ProjectDetail.create({
        requirement_id: req.id,
        project_id: @pro.id,
        content: Faker::GameOfThrones.quote})
    end
  end

end

puts "seeds 009_projects：Create 20 Projects"
