class CreateMyWombats < ActiveRecord::Migration
  def self.up
    create_table :my_wombats do |t|
      t.string :name
      t.text :description
      t.string :schedule

      t.timestamps
    end
  end

  def self.down
    drop_table :my_wombats
  end
end
