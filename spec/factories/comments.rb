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

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(3, true) }
    association :movie
    association :user
  end
end
