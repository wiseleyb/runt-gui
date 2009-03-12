class Schedule < ActiveRecord::Base
  
  attr_accessor :datetime_from, :datetime_to, :repeats, :all_day
  
  #daily
  attr_accessor :daily_repeat_every, :daily_ends, :daily_range
  
  #weekly
  attr_accessor :weekly_repeat_every, :weeky_repeat_on, :weekly_ends, :weekly_range,
      :wd0, :wd1, :wd2, :wd3, :wd4, :wd5, :wd6
  
  #monthly
  attr_accessor :monthly_repeat_every, :monthly_repeat_by, :monthly_range, :monthly_ends
  
  #yearly
  attr_accessor :yearly_repeat_every, :yearly_range, :yearly_ends
  
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
    s.daily_ends = s.datetime_to
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
  
end
