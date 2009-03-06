require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/my_wombats/index.html.erb" do
  include MyWombatsHelper
  
  before(:each) do
    assigns[:my_wombats] = [
      stub_model(MyWombat,
        :name => "value for name",
        :description => "value for description",
        :schedule => "value for schedule"
      ),
      stub_model(MyWombat,
        :name => "value for name",
        :description => "value for description",
        :schedule => "value for schedule"
      )
    ]
  end

  it "should render list of my_wombats" do
    render "/my_wombats/index.html.erb"
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for schedule".to_s, 2)
  end
end

