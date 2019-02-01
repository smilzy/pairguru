# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  user_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true
  validates :user_id, uniqueness: { scope: :movie_id, message: "You already commented on this movie" }

  scope :for_movie, -> (movie) { where(movie_id: movie.id) }
end
