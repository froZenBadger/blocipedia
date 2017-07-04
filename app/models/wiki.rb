class Wiki < ActiveRecord::Base
  belongs_to :user

  # scope :visible_to, -> (user) { user.premium ? all : joins(:wiki).where('wiki.private' => false) }

  validates :title, length: {minimum: 5 }, presence: true
  validates :body, length: {minimum: 20 }, presence: true
  validates :user, presence: true
end
