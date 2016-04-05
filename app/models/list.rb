class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards, -> { order(position: :asc) }, dependent: :destroy
  acts_as_list scope: :board
  validates :board, :name, presence: true
end
