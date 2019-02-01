class HomeController < ApplicationController
  def welcome
    @commenters = Comment.joins(:user)
      .group(:user_id)
      .where('comments.created_at >= ?', 7.days.ago)
      .select('users.id', 'users.name', 'count(user_id) as comments_count')
      .order('comments_count DESC')
      .limit(10).as_json
  end
end
