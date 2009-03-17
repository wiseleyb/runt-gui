# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090304181501) do

  create_table "schedules", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "schedule_description"
    t.datetime "datetime_from"
    t.datetime "datetime_to"
    t.string   "repeats"
    t.boolean  "all_day"
    t.integer  "daily_repeat_every"
    t.datetime "daily_ends"
    t.string   "daily_range"
    t.integer  "weekly_repeat_every"
    t.datetime "weekly_ends"
    t.string   "weekly_range"
    t.boolean  "wd0"
    t.boolean  "wd1"
    t.boolean  "wd2"
    t.boolean  "wd3"
    t.boolean  "wd4"
    t.boolean  "wd5"
    t.boolean  "wd6"
    t.integer  "monthly_repeat_every"
    t.string   "monthly_repeat_by"
    t.string   "monthly_range"
    t.datetime "monthly_ends"
    t.integer  "yearly_repeat_every"
    t.string   "yearly_range"
    t.datetime "yearly_ends"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
