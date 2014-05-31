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
        let!(:activity1) { Activity.create(name: "foobar1") }
        let!(:activity2) { Activity.create(name: "foobar2") }
        let!(:activity3) { Activity.create(name: "foobar3") }
        before do 
          visit root_path
        end

        it { should have_selector("li#activity#{activity1.id}", text: activity1.name) }
        it { should have_selector("li#activity#{activity2.id}", text: activity2.name) }
        it { should have_selector("li#activity#{activity3.id}", text: activity3.name) }
      end

    end
  end
end
