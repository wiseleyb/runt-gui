class CreateScheduleDetails < ActiveRecord::Migration
  def self.up
    create_table :schedule_details do |t|
      t.integer :schedule_id
      t.text :notes
      t.datetime :schedule_date

      t.timestamps
    end
  end

  def self.down
    drop_table :schedule_details
  end
end
