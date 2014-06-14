require 'spec_helper'

describe "Activities page" do
  subject { page }

  before { visit activities_path }

  describe "when not signed in" do
  it "should redirect to login" do
        expect(current_path).to eq new_user_session_path
      end    
  end

  describe "when signed in" do
    let!(:user) { FactoryGirl.create(:user) }

    before do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit activities_path
    end

    it { should have_link("New activity", href: new_activity_path) }

    describe "without activities" do
      it { should have_content("No activities")}
    end

    describe "with activities" do 
      before do 
        3.times do 
          FactoryGirl.create(:activity, user: user)
        end
        visit activities_path
      end

      it "should show all activities" do
        activities = user.activities.to_a
        activities.each do |activity|
          expect(page).to have_selector("li", text: activity.name)
        end
      end
      
    end


  end
end