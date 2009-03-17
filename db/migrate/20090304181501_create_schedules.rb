class CreateSchedules < ActiveRecord::Migration
  def self.up
    # create_table :schedules do |t|
    #   t.string    :name
    #   t.text      :description
    #   t.string :schedule
    #   t.timestamps
    # end
    
    create_table :schedules do |t|
      t.string        :name
      t.text          :description
      t.string        :schedule_description
      t.datetime      :datetime_from
      t.datetime      :datetime_to
      t.string        :repeats
      t.boolean       :all_day
      
      t.integer       :daily_repeat_every
      t.datetime      :daily_ends
      t.string        :daily_range
      
      t.integer       :weekly_repeat_every
      t.datetime      :weekly_ends
      t.string        :weekly_range
      t.boolean       :wd0
      t.boolean       :wd1
      t.boolean       :wd2
      t.boolean       :wd3
      t.boolean       :wd4
      t.boolean       :wd5
      t.boolean       :wd6
      
      t.integer       :monthly_repeat_every
      t.string        :monthly_repeat_by
      t.string        :monthly_range
      t.datetime      :monthly_ends
      
      t.integer       :yearly_repeat_every
      t.string        :yearly_range
      t.datetime      :yearly_ends
      
      t.timestamps
    end

  end

  def self.down
    drop_table :schedules
  end
end
