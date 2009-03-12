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
    @schedule.datetime_from = DateTime.parse(@schedule.datetime_from)
    s = Runt::AfterTE.new(@schedule.datetime_from - 1)
    
    if @schedule.repeats == "daily"
      s = s & Runt::DayIntervalTE.new(@schedule.datetime_from.to_time,@schedule.daily_repeat_every.to_i)
      if @schedule.daily_range == "until" && !@schedule.daily_ends.blank?
        s = s & Runt::BeforeTE.new(DateTime.parse(@schedule.daily_ends) + 1)
      end
    end
    
    if @schedule.repeats == "weekly"
      s = s & Runt::EveryTE.new(@schedule.datetime_from, @schedule.weekly_repeat_every.to_i, Runt::DPrecision::Precision.week)
      if @schedule.weekly_range == "until" && !@schedule.weekly_ends.blank?
        s = s & Runt::BeforeTE.new(DateTime.parse(@schedule.weekly_ends) + 1)
      end
      sweeks = nil
      6.times do |i|
        if @schedule.send("wd#{i}").to_i == 1
          if sweeks.nil?
            sweeks = Runt::DIWeek.new(i)
          else
            sweeks = sweeks | Runt::DIWeek.new(i)
          end
        end
      end
      s = s & (sweeks) unless sweeks.nil?
    end
    #raise s.to_s
    @schedule.schedule = s
    @schedules = [@schedule]
    #render :action => "new"
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
end
