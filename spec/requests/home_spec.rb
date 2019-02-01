require "rails_helper"

describe "Home requests", type: :request do
  describe "#welcome" do

    context 'with top commenters' do
      let!(:comment) { create(:comment) }
      it "displays top commenters" do
        visit "/"
        expect(page).to have_selector("h2", text: "Top commenters this week")
      end
    end

    context 'without top commenters' do
      it "displays top commenters" do
        visit "/"
        expect(page).to have_no_selector("h2", text: "Top commenters this week")
      end
    end

  end
end
