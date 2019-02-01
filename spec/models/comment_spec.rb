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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { create(:comment) }

  context 'user commented' do
    let!(:new_comment) { build(:comment, user_id: subject.user_id, movie_id: subject.movie_id) }
    it { expect(new_comment.save).to be_falsey }
  end

  context 'user has not commented' do
    let!(:new_comment) { build(:comment, user_id: subject.user_id) }
    it { expect(new_comment.save).to be_truthy }
  end
end
