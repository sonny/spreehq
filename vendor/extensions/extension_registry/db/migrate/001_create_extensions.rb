class CreateExtensions < ActiveRecord::Migration
  def self.up
    create_table :extensions do |t|
      t.string :name
      t.string :description
      t.string :git_location
      t.timestamps
    end
  end

  def self.down
    drop_table :extensions
  end
end
