class CreateCollections < ActiveRecord::Migration
  def change
    # create the Collections table
    create_table :collections do |t|
      t.integer :suite_num
      t.timestamps null: false
    end

    # add foreign key to Rooms table
    add_foreign_key :rooms, :collections
  end
end
