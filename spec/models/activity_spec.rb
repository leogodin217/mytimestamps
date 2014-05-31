require 'spec_helper'

describe "Activities" do
  subject { @activity } 

  before  do
    @activity = Activity.create(name: "foobar")
  end

  it { should respond_to(:name) }
  it { should respond_to(:created_at) }


end