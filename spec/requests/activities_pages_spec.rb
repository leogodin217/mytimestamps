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

      it "should show activities count" do
        expect(page).to have_content "3 activities" 
        FactoryGirl.create(:activity, user: user)
        visit activities_path
        expect(page).to have_content "4 activities"
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

    describe "showing activities" do
      let!(:activity) { FactoryGirl.create(:activity) }

      before { visit activity_path(activity.id) }

      it { should have_content activity.name }
      it { should have_content activity.created_at }

      it "should have a edit link" do
        expect(page).to have_link "Edit", edit_activity_path(activity.id)
      end
    end

    describe "creating activities" do
      before { visit new_activity_path }

      describe "with invalid information" do

        before { click_button "Submit" }

        it "should redisplay the form" do
          expect(page).to have_selector "form#new_activity"
        end

        it { should have_content "Name can't be blank" }

        it "should show error count" do
          activity = user.activities.new 
          activity.save
          error_count = activity.errors.count
          expect(error_count).to be > 0
          expect(page).to have_content(
            "The form contains #{error_count} #{'error'.pluralize(error_count)}")   
        end 
      end

      describe "with valid information" do
        
        let(:activity) { FactoryGirl.build(:activity) }

        before do
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

    describe "editing activities" do
      let(:activity) { FactoryGirl.create(:activity, user_id: user.id) }
      
      before { visit edit_activity_path(activity.id) }      

      describe "with invalid information" do

        before do
          fill_in "Name", with: ""
          click_button "Submit"
        end

        it "should redisplay the form" do
          expect(page).to have_selector "form#edit_activity_#{activity.id}"
        end

        it { should have_content "Name can't be blank" }

        it "should show error count" do
          activity = user.activities.new 
          activity.save
          error_count = activity.errors.count
          expect(error_count).to be > 0
          expect(page).to have_content(
            "The form contains #{error_count} #{'error'.pluralize(error_count)}")   
        end 
      end

      describe "with valid information" do
        
        let(:changed_activity) { FactoryGirl.build(:activity) }

        before do
          fill_in "Name", with: changed_activity.name
        end


        it "should save the new activity" do
          attribute_exceptions = [:id, :created_at, :updated_at]
          click_button "Submit"
          activity.reload

          expect(activity.name).to eq changed_activity.name
        end

        it "should flash a success message" do
          click_button "Submit"
          expect(page).to have_content "Activity successfully updated"
        end
      end

    end

    describe "destroying activities" do
        let(:activity) { FactoryGirl.create(:activity, user_id: user.id) }
      before do
        visit edit_activity_path(activity.id)
      end      

      it "should delete the activity" do
        expect{click_link("Delete")}.to change{Activity.count}.by(-1)
      end

      it "should flash a message" do
        click_link "Delete"
        expect(page).to have_content "Activity successfully deleted."
      end
    end    
  end
end