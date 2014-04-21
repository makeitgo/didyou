class AddCounters < ActiveRecord::Migration
  def change
    create_table :counter_groups do |table|
      table.string :name
    end
    
    create_table :counter_items do |table|
      table.string :name
      table.integer :counter_group_id
      table.integer :count 
    end
  end
end
