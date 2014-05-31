require 'spec_helper'

describe "Information pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('My Timestamps') }
    it { should have_title('My Timestamps') }
  end
end
