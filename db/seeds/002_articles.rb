# -*- coding: utf-8 -*-
require 'faker'

admin = User.find_by(email: 'admin@mcutgarage.com')
examiner = User.find_by(email: 'examiner@mcutgarage.com')
faculty = User.find_by(email: 'faculty@mcutgarage.com')

articles = [
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 2, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: examiner, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 2, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: faculty, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 2, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 0, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 1, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 2, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 1, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 0, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 2, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 1, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 0, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
  { author: admin, title: Faker::GameOfThrones.quote, content: Faker::Food.description, status: 2, published_at: Faker::Time.between(DateTime.now - 1, DateTime.now)},
]

articles.each do | a |
  u = Article.new title: a[:title],
    content: a[:content],
    status: a[:status],
    user_id: a[:author].id,
    published_at: a[:published_at]
  u.save!
end

puts "seeds 002_articles: Create Many Articles"
