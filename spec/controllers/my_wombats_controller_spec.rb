require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MyWombatsController do

  def mock_my_wombat(stubs={})
    @mock_my_wombat ||= mock_model(MyWombat, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all my_wombats as @my_wombats" do
      MyWombat.should_receive(:find).with(:all).and_return([mock_my_wombat])
      get :index
      assigns[:my_wombats].should == [mock_my_wombat]
    end

    describe "with mime type of xml" do
  
      it "should render all my_wombats as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        MyWombat.should_receive(:find).with(:all).and_return(my_wombats = mock("Array of MyWombats"))
        my_wombats.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested my_wombat as @my_wombat" do
      MyWombat.should_receive(:find).with("37").and_return(mock_my_wombat)
      get :show, :id => "37"
      assigns[:my_wombat].should equal(mock_my_wombat)
    end
    
    describe "with mime type of xml" do

      it "should render the requested my_wombat as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        MyWombat.should_receive(:find).with("37").and_return(mock_my_wombat)
        mock_my_wombat.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new my_wombat as @my_wombat" do
      MyWombat.should_receive(:new).and_return(mock_my_wombat)
      get :new
      assigns[:my_wombat].should equal(mock_my_wombat)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested my_wombat as @my_wombat" do
      MyWombat.should_receive(:find).with("37").and_return(mock_my_wombat)
      get :edit, :id => "37"
      assigns[:my_wombat].should equal(mock_my_wombat)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created my_wombat as @my_wombat" do
        MyWombat.should_receive(:new).with({'these' => 'params'}).and_return(mock_my_wombat(:save => true))
        post :create, :my_wombat => {:these => 'params'}
        assigns(:my_wombat).should equal(mock_my_wombat)
      end

      it "should redirect to the created my_wombat" do
        MyWombat.stub!(:new).and_return(mock_my_wombat(:save => true))
        post :create, :my_wombat => {}
        response.should redirect_to(my_wombat_url(mock_my_wombat))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved my_wombat as @my_wombat" do
        MyWombat.stub!(:new).with({'these' => 'params'}).and_return(mock_my_wombat(:save => false))
        post :create, :my_wombat => {:these => 'params'}
        assigns(:my_wombat).should equal(mock_my_wombat)
      end

      it "should re-render the 'new' template" do
        MyWombat.stub!(:new).and_return(mock_my_wombat(:save => false))
        post :create, :my_wombat => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested my_wombat" do
        MyWombat.should_receive(:find).with("37").and_return(mock_my_wombat)
        mock_my_wombat.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :my_wombat => {:these => 'params'}
      end

      it "should expose the requested my_wombat as @my_wombat" do
        MyWombat.stub!(:find).and_return(mock_my_wombat(:update_attributes => true))
        put :update, :id => "1"
        assigns(:my_wombat).should equal(mock_my_wombat)
      end

      it "should redirect to the my_wombat" do
        MyWombat.stub!(:find).and_return(mock_my_wombat(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(my_wombat_url(mock_my_wombat))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested my_wombat" do
        MyWombat.should_receive(:find).with("37").and_return(mock_my_wombat)
        mock_my_wombat.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :my_wombat => {:these => 'params'}
      end

      it "should expose the my_wombat as @my_wombat" do
        MyWombat.stub!(:find).and_return(mock_my_wombat(:update_attributes => false))
        put :update, :id => "1"
        assigns(:my_wombat).should equal(mock_my_wombat)
      end

      it "should re-render the 'edit' template" do
        MyWombat.stub!(:find).and_return(mock_my_wombat(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested my_wombat" do
      MyWombat.should_receive(:find).with("37").and_return(mock_my_wombat)
      mock_my_wombat.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the my_wombats list" do
      MyWombat.stub!(:find).and_return(mock_my_wombat(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(my_wombats_url)
    end

  end

end
