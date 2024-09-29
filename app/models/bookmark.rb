class Bookmark < ApplicationRecord
  belongs_to :list
  belongs_to :movie

  validates :list, presence: true, uniqueness: { scope: :movie }
  validates :comment, presence: true, length: { minimum: 6 }
end
