require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MyWombatsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "my_wombats", :action => "index").should == "/my_wombats"
    end
  
    it "should map #new" do
      route_for(:controller => "my_wombats", :action => "new").should == "/my_wombats/new"
    end
  
    it "should map #show" do
      route_for(:controller => "my_wombats", :action => "show", :id => 1).should == "/my_wombats/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "my_wombats", :action => "edit", :id => 1).should == "/my_wombats/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "my_wombats", :action => "update", :id => 1).should == "/my_wombats/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "my_wombats", :action => "destroy", :id => 1).should == "/my_wombats/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/my_wombats").should == {:controller => "my_wombats", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/my_wombats/new").should == {:controller => "my_wombats", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/my_wombats").should == {:controller => "my_wombats", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/my_wombats/1").should == {:controller => "my_wombats", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/my_wombats/1/edit").should == {:controller => "my_wombats", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/my_wombats/1").should == {:controller => "my_wombats", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/my_wombats/1").should == {:controller => "my_wombats", :action => "destroy", :id => "1"}
    end
  end
end
