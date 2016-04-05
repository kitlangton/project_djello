class Card < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: :list

  validates :body, :list, presence: true
end
