require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/my_wombats/new.html.erb" do
  include MyWombatsHelper
  
  before(:each) do
    assigns[:my_wombat] = stub_model(MyWombat,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :schedule => "value for schedule"
    )
  end

  it "should render new form" do
    render "/my_wombats/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", my_wombats_path) do
      with_tag("input#my_wombat_name[name=?]", "my_wombat[name]")
      with_tag("textarea#my_wombat_description[name=?]", "my_wombat[description]")
      with_tag("input#my_wombat_schedule[name=?]", "my_wombat[schedule]")
    end
  end
end


