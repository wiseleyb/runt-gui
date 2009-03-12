require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/schedules/edit.html.erb" do
  include SchedulesHelper
  
  before(:each) do
    assigns[:schedule] = @schedule = stub_model(Schedule,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description",
      :schedule => "value for schedule"
    )
  end

  it "should render edit form" do
    render "/schedules/edit.html.erb"
    
    response.should have_tag("form[action=#{schedule_path(@schedule)}][method=post]") do
      with_tag('input#schedule_name[name=?]', "schedule[name]")
      with_tag('textarea#schedule_description[name=?]', "schedule[description]")
      with_tag('input#schedule_schedule[name=?]', "schedule[schedule]")
    end
  end
end


