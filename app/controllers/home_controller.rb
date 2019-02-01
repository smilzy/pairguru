class HomeController < ApplicationController
  def welcome
    @commenters = Comment.joins(:user).group(:user_id).where('comments.created_at >= ?', 7.days.ago).order('count(user_id) DESC').select('users.id', 'users.name', 'count(user_id) as comments_count').limit(10).as_json
  end
end
