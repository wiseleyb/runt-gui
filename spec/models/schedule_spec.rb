require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Schedule do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :schedule => "value for schedule"
    }
  end

  it "should create a new instance given valid attributes" do
    Schedule.create!(@valid_attributes)
  end
end
