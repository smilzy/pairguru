class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.includes(comments: [:user]).find(params[:id]).decorate
    @comment = current_user.comments.for_movie(@movie).first_or_initialize
  end

  def add_comment
    @movie = Movie.find(params[:id])
    if current_user.comments.for_movie(@movie).create(comment_params)
      redirect_to movie_path(@movie), notice: "Comment created"
    else
      flash.now[:alert] = "An error occurred"
      render :show
    end
  end

  def delete_comment
    @movie = Movie.find(params[:id])
    @comment = current_user.comments.for_movie(@movie).first
    @comment.destroy
    redirect_to movie_path(@movie), notice: "Comment deleted"
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporterJob.new(current_user, file_path).perform_later
    redirect_to root_path, notice: "Movies exported"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
