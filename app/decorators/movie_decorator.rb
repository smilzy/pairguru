class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def poster
    url = Movie::BASE_URL + "/#{api_data.dig('data', 'attributes', 'poster')}"
  end

  def rating
    return api_data.dig('data', 'attributes', 'rating')
  end

  def plot_overview
    return api_data.dig('data', 'attributes', 'plot')
  end
end
