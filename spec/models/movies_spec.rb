require "rails_helper"

RSpec.describe Movie, type: :model do
  subject { create(:movie) }

  context 'wrong title' do
    it { expect(subject.api_data).to eq ({"message"=>"Couldn't find Movie"}) }
  end

  context 'correct title' do
    let(:movie) { create(:movie, title: 'Deadpool') }
    
    it { expect(movie.api_data.dig('data', 'attributes', 'title')).to eq movie.title }
  end
end
