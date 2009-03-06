class MyWombatsController < ApplicationController
  # GET /my_wombats
  # GET /my_wombats.xml
  def index
    @my_wombats = MyWombat.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_wombats }
    end
  end

  # GET /my_wombats/1
  # GET /my_wombats/1.xml
  def show
    @my_wombat = MyWombat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_wombat }
    end
  end

  # GET /my_wombats/new
  # GET /my_wombats/new.xml
  def new
    @my_wombat = MyWombat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_wombat }
    end
  end

  # GET /my_wombats/1/edit
  def edit
    @my_wombat = MyWombat.find(params[:id])
  end

  # POST /my_wombats
  # POST /my_wombats.xml
  def create
    @my_wombat = MyWombat.new(params[:my_wombat])

    respond_to do |format|
      if @my_wombat.save
        flash[:notice] = 'MyWombat was successfully created.'
        format.html { redirect_to(@my_wombat) }
        format.xml  { render :xml => @my_wombat, :status => :created, :location => @my_wombat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_wombat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my_wombats/1
  # PUT /my_wombats/1.xml
  def update
    @my_wombat = MyWombat.find(params[:id])

    respond_to do |format|
      if @my_wombat.update_attributes(params[:my_wombat])
        flash[:notice] = 'MyWombat was successfully updated.'
        format.html { redirect_to(@my_wombat) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_wombat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my_wombats/1
  # DELETE /my_wombats/1.xml
  def destroy
    @my_wombat = MyWombat.find(params[:id])
    @my_wombat.destroy

    respond_to do |format|
      format.html { redirect_to(my_wombats_url) }
      format.xml  { head :ok }
    end
  end
end
