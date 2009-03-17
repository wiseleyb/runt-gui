class ScheduleDetailsController < ApplicationController
  # GET /schedule_details
  # GET /schedule_details.xml
  def index
    @schedule_details = ScheduleDetail.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schedule_details }
    end
  end

  # GET /schedule_details/1
  # GET /schedule_details/1.xml
  def show
    @schedule_detail = ScheduleDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @schedule_detail }
    end
  end

  # GET /schedule_details/new
  # GET /schedule_details/new.xml
  def new
    @schedule_detail = ScheduleDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schedule_detail }
    end
  end

  # GET /schedule_details/1/edit
  def edit
    @schedule_detail = ScheduleDetail.find(params[:id])
  end

  # POST /schedule_details
  # POST /schedule_details.xml
  def create
    @schedule_detail = ScheduleDetail.new(params[:schedule_detail])
    @schedule_detail.save
    redirect_to "/schedules/show/#{@schedule_detail.schedule_id}?sdate=#{@schedule_detail.schedule_date.strftime("%Y-%m-%d")}"
    # respond_to do |format|
    #   if @schedule_detail.save
    #     flash[:notice] = 'ScheduleDetail was successfully created.'
    #     format.html { redirect_to(@schedule_detail) }
    #     format.xml  { render :xml => @schedule_detail, :status => :created, :location => @schedule_detail }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @schedule_detail.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # PUT /schedule_details/1
  # PUT /schedule_details/1.xml
  def update
    @schedule_detail = ScheduleDetail.find(params[:id])
    @schedule_detail.update_attributes(params[:schedule_detail])
    redirect_to "/schedules/show/#{@schedule_detail.schedule_id}?sdate=#{@schedule_detail.schedule_date.strftime("%Y-%m-%d")}"

    # respond_to do |format|
    #   if @schedule_detail.update_attributes(params[:schedule_detail])
    #     flash[:notice] = 'ScheduleDetail was successfully updated.'
    #     format.html { redirect_to(@schedule_detail) }
    #     format.xml  { head :ok }
    #   else
    #     format.html { render :action => "edit" }
    #     format.xml  { render :xml => @schedule_detail.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /schedule_details/1
  # DELETE /schedule_details/1.xml
  def destroy
    @schedule_detail = ScheduleDetail.find(params[:id])
    @schedule_detail.destroy

    respond_to do |format|
      format.html { redirect_to(schedule_details_url) }
      format.xml  { head :ok }
    end
  end
end
