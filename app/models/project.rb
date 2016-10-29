class Project < ActiveRecord::Base
  validates_presence_of :name
  has_one :user_project
  has_one :user, through: :user_project
end
