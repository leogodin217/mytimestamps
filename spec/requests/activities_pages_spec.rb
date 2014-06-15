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

    describe "listing activities" do 
      before do 
        3.times do 
          FactoryGirl.create(:activity, user: user)
        end
        visit activities_path
      end

      it "should show all activities" do
        activities = user.activities

        activities.each do |activity|
          expect(page).to have_selector("tr#activity#{activity.id}>td", 
                                         text: activity.name)
        end
      end

      it "should link to show activity" do
        activities = user.activities

        activities.each do |activity|
          expect(page).to have_selector("a[href='#{activity_path(activity.id)}']",
                                         text: activity.name)
        end
      end

      it "should show create timestamp" do
        activities = user.activities

        activities.each do |activity|
          expect(page).to have_selector("tr#activity#{activity.id}>td", 
                                         text: activity.created_at)
        end
      end
    end

    describe "creating activities" do
      let(:activity) { FactoryGirl.build(:activity) }

      before do
        visit new_activity_path
        fill_in "Name", with: activity.name
      end


      it "should create the activity" do
        expect{click_button("Submit")}.to change{Activity.count}.by(1)  
      end

      it "should flash a success message" do
        click_button "Submit"
        expect(page).to have_content "Activity successfully created"
      end
    end

  end

end