class Card < ActiveRecord::Base
  belongs_to :list

  validates :body, :list, presence: true
end
