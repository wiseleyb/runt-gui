class Schedule < ActiveRecord::Base

  # Ran out of time - was having problems with serialization of runt objects... just made these into columns... will revist later
  # #serialize :schedule
  # 
  # attr_accessor :datetime_from, :datetime_to, :repeats, :all_day
  # 
  # #daily
  # attr_accessor :daily_repeat_every, :daily_ends, :daily_range
  # 
  # #weekly
  # attr_accessor :weekly_repeat_every, :weeky_repeat_on, :weekly_ends, :weekly_range,
  #     :wd0, :wd1, :wd2, :wd3, :wd4, :wd5, :wd6
  # 
  # #monthly
  # attr_accessor :monthly_repeat_every, :monthly_repeat_by, :monthly_range, :monthly_ends
  # 
  # #yearly
  # attr_accessor :yearly_repeat_every, :yearly_range, :yearly_ends
  has_many :schedule_details, :dependent => :destroy
  
  attr_accessor :schedule
  
  REPEAT_OPTIONS = {
    :does_not_repeat => "Does not repeat",
    :daily => "Daily",
    :weekly => "Weekly",
    :monthly => "Monthly",
    :yearly => "Yearly"
  }
  
  # w = %w(S M T W T F S)
  # i = 0
  # arr = []
  # w.each do |d|
  # arr << [i,d]
  #   i += 1
  # end
  DAYS_OF_WEEK = [[0, "S"], [1, "M"], [2, "T"], [3, "W"], [4, "T"], [5, "F"], [6, "S"]]

  
  def self.new_default
    s = Schedule.new
    s.name = "Schedule"
    s.datetime_from = DateTime.parse(DateTime.now.strftime("%Y-%m-%d %H:00"))
    s.datetime_to   = s.datetime_from 
    s.repeats = "does_not_repeat"
    s.daily_repeat_every = 1
    s.daily_range = "never"
    s.weekly_range = "never"
    s.monthly_range = "never"
    s.yearly_range = "never"
    #s.daily_ends = s.datetime_to
    #s.schedule = Runt::DIMonth.new(Runt::Last_of,Runt::Mon) | Runt::DIWeek.new(Runt::Wed) | Runt::DIWeek.new(Runt::Fri)
    s.schedule = Runt::DayIntervalTE.new(s.datetime_from.to_date,3)
    return s
  end

  def self.for_options
    res = []
    [:does_not_repeat, :daily, :weekly, :monthly, :yearly].each do |k|
      res << [REPEAT_OPTIONS[k], k.to_s]
    end
    return res
  end
  
  def schedule_detail(d)
    ScheduleDetail.find(:first, 
      :conditions => ["schedule_id = ? and date(schedule_date) = ?", self.id, d.strftime("%Y-%m-%d")])
  end

  def schedule
    # runt docs:  http://runt.rubyforge.org/

    s = Runt::AfterTE.new(self.datetime_from - 1.day)
    
    if self.repeats == "does_not_repeat"
      s = s & Runt::REMonth.new(self.datetime_from.day)
      s = s & Runt::REYear.new(self.datetime_from.month)
      s = s & Runt::YearTE.new(self.datetime_from.year)
    end
    
    if self.repeats == "daily"
      s = s & Runt::DayIntervalTE.new(self.datetime_from.to_time,self.daily_repeat_every.to_i)
      if self.daily_range == "until" && !self.daily_ends.blank?
        s = s & Runt::BeforeTE.new(DateTime.parse(self.daily_ends) + 1)
      end
    end
    
    if self.repeats == "weekly"
      s = s & Runt::EveryTE.new(self.datetime_from, self.weekly_repeat_every.to_i, Runt::DPrecision::Precision.week)
      if self.weekly_range == "until" && !self.weekly_ends.blank?
        s = s & Runt::BeforeTE.new(DateTime.parse(self.weekly_ends) + 1)
      end
      sweeks = nil
      6.times do |i|
        if self.send("wd#{i}")
          if sweeks.nil?
            sweeks = Runt::DIWeek.new(i)
          else
            sweeks = sweeks | Runt::DIWeek.new(i)
          end
        end
      end
      s = s & (sweeks) unless sweeks.nil?
    end
    
    if self.repeats == "monthly"
      s = s & Runt::EveryTE.new(self.datetime_from, self.monthly_repeat_every.to_i, Runt::DPrecision::Precision.month)
      if self.monthly_range == "until" && !self.monthly_ends.blank?
        s = s & Runt::BeforeTE.new(DateTime.parse(self.monthly_ends) + 1)
      end
      if self.monthly_repeat_by == "day_of_month"
        s = s & Runt::REMonth.new(self.datetime_from.day)
      end
      if self.monthly_repeat_by == "day_of_week"
        #clean this up - this is a total hack
        days = self.datetime_from.end_of_month.day
        icount = 0
        days.times do |i|
          d = DateTime.parse("#{self.datetime_from.year}-#{self.datetime_from.month}-#{i+1}")
          icount += 1 if d.wday == self.datetime_from.wday
          break if d.day == self.datetime_from.day
        end
        if icount > 0
          if icount > 4
            s = s & Runt::DIMonth.new(-1, self.datetime_from.wday)
          else
            s = s & Runt::DIMonth.new(icount, self.datetime_from.wday)
          end
        end
      end
    end
    
    if self.repeats == "yearly"
      s = s & Runt::EveryTE.new(self.datetime_from, self.yearly_repeat_every.to_i, Runt::DPrecision::Precision.month)
      s = s & Runt::REMonth.new(self.datetime_from.day)
      s = s & Runt::REYear.new(self.datetime_from.month)
      if self.yearly_range == "until" && !self.yearly_ends.blank?
        s = s & Runt::BeforeTE.new(DateTime.parse(self.yearly_ends) + 1)
      end
    end
    
    return s
  end
  
  
end
