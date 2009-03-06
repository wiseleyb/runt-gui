require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/my_wombats/show.html.erb" do
  include MyWombatsHelper
  before(:each) do
    assigns[:my_wombat] = @my_wombat = stub_model(MyWombat,
      :name => "value for name",
      :description => "value for description",
      :schedule => "value for schedule"
    )
  end

  it "should render attributes in <p>" do
    render "/my_wombats/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ schedule/)
  end
end

