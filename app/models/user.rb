# -*- coding: utf-8 -*-
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :projects_users
  has_many :projects, through: :projects_users
  has_many :articles
  has_many :project_members
  has_many :users_roles
  has_and_belongs_to_many :roles, :join_table => :users_roles
  acts_as_paranoid
  has_paper_trail
  validates :phone, format:{with: /\A09\d{8}\z/,
    message: '您的手機號碼格式不正確'}
  validates :phone, uniqueness: true

end
