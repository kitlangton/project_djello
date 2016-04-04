class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board, :name, presence: true
end
