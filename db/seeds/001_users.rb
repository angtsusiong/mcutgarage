# -*- coding: utf-8 -*-
roles = [
  { role: 'admin', name: '管理員', phone: '0987654321', email: 'admin@mcutgarage.com'},
  { role: 'examiner', name: '審查委員', phone: '0987654322', email: 'examiner@mcutgarage.com'},
  { role: 'faculty', name: '教職員', phone: '0987654323', email: 'faculty@mcutgarage.com'},
  { role: 'member', name: '成員', phone: '0987654324', email: 'member@mcutgarage.com'},
  { role: 'reserve5', name: '保留5', phone: '0987654325', email: 'reserve5@mcutgarage.com'},
  { role: 'reserve6', name: '保留6', phone: '0987654326', email: 'reserve6@mcutgarage.com'},
  { role: 'reserve7', name: '保留7', phone: '0987654327', email: 'reserve7@mcutgarage.com'},
  { role: 'reserve8', name: '保留8', phone: '0987654328', email: 'reserve8@mcutgarage.com'},
  { role: 'reserve9', name: '保留9', phone: '0987654329', email: 'reserve9@mcutgarage.com'},
  { role: 'reserve10', name: '保留10', phone: '0987654320', email: 'reserve10@mcutgarage.com'},
]

roles.each do | r |
  u = User.create!(
    {
      email: r[:email],
      password: "12345678",
      password_confirmation: '12345678',
      name: r[:name],
      phone: r[:phone],
    }
  )
  u.roles.destroy_all
  u.add_role r[:role].to_sym
  u.save!
end

puts "seeds 001_users: Create users and roles"
