# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments, dependent: :destroy

  require 'net/http'
  require 'uri'

  BASE_URL  = 'https://pairguru-api.herokuapp.com'
  API_URL   = 'https://pairguru-api.herokuapp.com/api/v1/movies'

  def api_data
    return @api_data if @api_data.present?
    uri   = URI.encode(API_URL + "/#{title}")
    uri   = URI.parse(uri)
    res   = Net::HTTP.get_response(uri)
    json  = JSON.parse(res.body)
    puts "Response: #{json}"
    @api_data = json
  end
end
