require 'spec_helper'

describe "Activities" do
  subject { @activity } 

  before  do
    @activity = Activity.create(name: "foobar")
    @activty = FactoryGirl.create(:activity)
  end

  it { should respond_to(:name) }
  it { should respond_to(:created_at) }
  it { should respond_to(:user) }

  describe "validation" do

    it "should require a name" do
      @activity.name = ""
      @activity.save
      expect(@activity).not_to be_valid
    end

    it "should require a user" do
      @activity.user = nil
      @activity.save
      expect(@activity).not_to be_valid
    end
  end


end