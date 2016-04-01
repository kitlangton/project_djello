class User < ActiveRecord::Base
  has_many :boards
  has_many :board_memberships
  has_many :joined_boards, through: :board_memberships, source: :board

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
end
