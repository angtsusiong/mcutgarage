# -*- coding: utf-8 -*-
('01'..'10').to_a.each do |n|
  u = User.new({
    email: 'admin' + n.to_s + '@mcutgarage.com',
    password: '12345678',
    password_confirmation: '12345678',
    name: '管' + n.to_s,
    phone: '0911' + '4444' + n.to_s, })
  u.save
  u.add_role :admin
end
puts "seeds 003_accounts_admins: Creates 10 Admins. (11..20)"

('01'..'50').to_a.each do |n|
  u = User.new({
    email: 'examiner' + n.to_s + '@mcutgarage.com',
    password: '12345678',
    password_confirmation: '12345678',
    name: '審' + n.to_s,
    phone: '09224444' + n.to_s, })
  u.save
  u.add_role :examiner
end
puts "seeds 003_accounts_examiners: Creates 50 Examiners. (21..70)"

('01'..'20').to_a.each do |n|
  u = User.new({
    email: 'faculty' + n.to_s + '@mcutgarage.com',
    password: '12345678',
    password_confirmation: '12345678',
    name: '師' + n.to_s,
    phone: '09334444' + n.to_s, })
  u.save
  u.add_role :faculty
end
puts "seeds 003_accounts_faculties: Create 20 Faculties. (71..90)"

('01'..'50').to_a.each do |n|
  u = User.new({
    email: 'member' + n.to_s + '@mcutgarage.com',
    password: '12345678',
    password_confirmation: '12345678',
    name: Faker::Name.name,
    phone: '09444444' + n })
  u.save
  u.add_role :member
end
puts "seeds 003_accounts_members: Create 50 Members. (91..140)"
