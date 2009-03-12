require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/schedules/new.html.erb" do
  include SchedulesHelper
  
  before(:each) do
    assigns[:schedule] = stub_model(Schedule,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :schedule => "value for schedule"
    )
  end

  it "should render new form" do
    render "/schedules/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", schedules_path) do
      with_tag("input#schedule_name[name=?]", "schedule[name]")
      with_tag("textarea#schedule_description[name=?]", "schedule[description]")
      with_tag("input#schedule_schedule[name=?]", "schedule[schedule]")
    end
  end
end


