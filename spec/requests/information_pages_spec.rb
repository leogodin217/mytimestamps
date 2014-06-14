require 'spec_helper'

describe "Information pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('My Timestamps') }
    it { should have_title('My Timestamps') }

    describe "when not signed in" do
      before { visit root_path }

      it { should have_link('Sign in', href: new_user_session_path) }
      it { should have_link('Sign up', href: new_user_registration_path) }
    end

    describe "when signed in" do 
      let!(:user) { FactoryGirl.create(:user) }

      before do
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should_not have_link('Sign in', href: new_user_session_path) }
      it { should_not have_link('Sign up', href: new_user_registration_path) }
      it { should have_link('Sign out', href: destroy_user_session_path) }
    end
   
  end
end
