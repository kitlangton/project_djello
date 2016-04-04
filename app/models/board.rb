class Board < ActiveRecord::Base
  validates :name, :user, presence: true
  belongs_to :user
  has_many :board_memberships, dependent: :destroy
  has_many :members, through: :board_memberships, source: :user
  has_many :lists

  after_create :add_creator_membership

  def add_creator_membership
    self.members << user
  end
end
