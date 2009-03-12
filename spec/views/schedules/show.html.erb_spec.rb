require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/schedules/show.html.erb" do
  include SchedulesHelper
  before(:each) do
    assigns[:schedule] = @schedule = stub_model(Schedule,
      :name => "value for name",
      :description => "value for description",
      :schedule => "value for schedule"
    )
  end

  it "should render attributes in <p>" do
    render "/schedules/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ schedule/)
  end
end

