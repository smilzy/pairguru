class Api::V1::MoviesController < ActionController::Base

  def index
    if params[:with_genres].present?
      @movies = Movie.includes(:genre).all.map { |m| { id: m.id, title: m.title, genre_id: m.genre_id, genre_name: m.genre.name, genre_movie_count: m.genre.movies.count } }
      render json: { data: { movies: @movies } }
    elsif params[:genres_separately].present?
      query = Movie.joins(:genre)
      render json: {
        data: {
          movies: query.group('movies.id').select('movies.id', 'movies.title', 'movies.genre_id', 'genres.name as genre_name'),
          genres: query.group('genres.id').select('genres.id', 'genres.name as genre_name', 'count(genres.id) as genre_movie_count')
        }
      }
    else
      render json: { data: { movies: Movie.all.select(:id, :title) } }
    end

  end

  def show
    @movie = Movie.find(params[:id])

    if params[:with_genre].present?
      render json: {
        data: {
          movie: @movie,
          genre: {
            id: @movie.genre_id,
            name: @movie.genre.name,
            movies_count: @movie.genre.movies.count
          }
        }
      }
    else
      render json: {
        data: {
          movie: @movie
        }
      }
    end
  end

end
