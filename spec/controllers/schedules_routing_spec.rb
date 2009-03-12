require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SchedulesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "schedules", :action => "index").should == "/schedules"
    end
  
    it "should map #new" do
      route_for(:controller => "schedules", :action => "new").should == "/schedules/new"
    end
  
    it "should map #show" do
      route_for(:controller => "schedules", :action => "show", :id => 1).should == "/schedules/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "schedules", :action => "edit", :id => 1).should == "/schedules/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "schedules", :action => "update", :id => 1).should == "/schedules/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "schedules", :action => "destroy", :id => 1).should == "/schedules/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/schedules").should == {:controller => "schedules", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/schedules/new").should == {:controller => "schedules", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/schedules").should == {:controller => "schedules", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/schedules/1").should == {:controller => "schedules", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/schedules/1/edit").should == {:controller => "schedules", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/schedules/1").should == {:controller => "schedules", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/schedules/1").should == {:controller => "schedules", :action => "destroy", :id => "1"}
    end
  end
end
