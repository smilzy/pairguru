require 'rails_helper'

describe Api::V1::MoviesController, type: :request do
  describe '#index' do
    let!(:genre) { create(:genre, :with_movies) }
    let!(:movies) { genre.movies }

    context 'basic request' do
      before do
        get "/api/v1/movies"
      end

      it('returns http success') { expect(response).to be_successful }

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.dig('data', 'movies').map(&:values)).to eq(movies.pluck(:id, :title))
      end
    end

    context 'request with genres' do
      before do
        get "/api/v1/movies?with_genres=1"
      end

      it('returns http success') { expect(response).to be_successful }

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.dig('data', 'movies').map(&:values)).to eq(movies.pluck(:id, :title, :genre_id).map { |a| a.push(genre.name, movies.count) })
      end
    end
  end

  describe '#show' do
    let!(:genre) { create(:genre, :with_movies) }
    let!(:movie) { genre.movies.first }

    context 'basic request' do
      before do
        get "/api/v1/movies/#{movie.id}"
      end

      it('returns http success') { expect(response).to be_successful }

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.dig('data', 'movie').keys).to eq(movie.attributes.keys)
      end
    end

    context 'request with genre' do
      before do
        get "/api/v1/movies/#{movie.id}?with_genre=1"
      end

      it('returns http success') { expect(response).to be_successful }

      it 'JSON body response contains expected movie attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.dig('data', 'movie').keys).to eq(movie.attributes.keys)
      end

      it 'JSON body response contains expected genre attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.dig('data', 'genre').keys).to eq(%w(id name movies_count))
      end
    end
  end
end
