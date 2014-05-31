require 'spec_helper'

describe "Information pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('My Timestamps') }
    it { should have_title('My Timestamps') }

    describe "home page activites" do

      describe "without activities" do
        before { visit root_path }

        it "should be at the home path with no redirects" do
          # This tests that there weren't any errors
          expect(current_path).to eq root_path
        end
      end

      describe "With activites" do 

        before do 
          3.times do
            FactoryGirl.create(:activity)
          end
          visit root_path
        end
        it "should list each activity" do
          activities = Activity.all

          activities.each do |activity|
            expect(page).to have_selector("li#activity#{activity.id}", 
                                          text: activity.name) 
          end
          
        end

        it "should print the page" do
          puts page.body
        end
      end

    end
  end
end
