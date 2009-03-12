require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/schedules/index.html.erb" do
  include SchedulesHelper
  
  before(:each) do
    assigns[:schedules] = [
      stub_model(Schedule,
        :name => "value for name",
        :description => "value for description",
        :schedule => "value for schedule"
      ),
      stub_model(Schedule,
        :name => "value for name",
        :description => "value for description",
        :schedule => "value for schedule"
      )
    ]
  end

  it "should render list of schedules" do
    render "/schedules/index.html.erb"
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for schedule".to_s, 2)
  end
end

