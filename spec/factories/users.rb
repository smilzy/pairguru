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
  factory :user do
    name { Faker::Lorem.word }
    password 'password'
    sequence(:email) { |i| "#{i}-#{Faker::Internet.unique.email}" }
    phone_number '12345678'
  end
end
