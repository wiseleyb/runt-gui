class ScheduleDetail < ActiveRecord::Base
  belongs_to :schedule
  
  def self.find_or_create(sid, d)
    #TODO - make this DB independent
    sd = nil
    if !sid.blank? && !d.blank?
      sd = ScheduleDetail.find(:first, 
          :conditions => ["schedule_id = ? and date(schedule_date) = ?", sid, d.strftime("%Y-%m-%d")])
    end
    if sd.nil?
      sd = ScheduleDetail.new(:schedule_id => sid, :schedule_date => d)
    end
    return sd
  end
  
end
