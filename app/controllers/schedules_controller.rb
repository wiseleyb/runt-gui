class SchedulesController < ApplicationController
  # GET /schedules
  # GET /schedules.xml
  def index
    @schedules = Schedule.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show
    @schedule = Schedule.find(params[:id])
    @sdate = DateTime.parse(params[:sdate]) unless params[:sdate].blank?
    @sdate ||= @schedule.datetime_from
    @schedule_detail = ScheduleDetail.find_or_create(@schedule.id, @sdate)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.xml
  def new
    @schedule = Schedule.new_default
    @schedules = [@schedule]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.xml
  def create
    @schedule = Schedule.new(params[:schedule])
    @sdate = DateTime.parse(params[:sdate]) unless params[:sdate].blank?
    @sdate ||= @schedule.datetime_from
    @schedule_detail = ScheduleDetail.find_or_create(@schedule.id, @sdate)
    respond_to do |format|
      if @schedule.save
        flash[:notice] = 'Schedule was successfully created.'
        format.html { redirect_to(@schedule) }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.xml
  def update
    @schedule = Schedule.find(params[:id])
    @sdate = DateTime.parse(params[:sdate]) unless params[:sdate].blank?
    @sdate ||= @schedule.datetime_from
    @schedule_detail = ScheduleDetail.find_or_create(@schedule.id, @sdate)

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        flash[:notice] = 'Schedule was successfully updated.'
        format.html { redirect_to(@schedule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.xml
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
  
  def change_date
    @date = DateTime.parse("#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}")
    if params[:id]
      @schedule = Schedule.find_by_id params[:id].to_i
    else
      @schedules = Schedule.find(:all)
    end
    render :partial => "/schedules/cal"
  end
  
end
