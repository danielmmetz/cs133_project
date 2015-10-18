class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :draw_group_id
      t.integer :collection_id
      t.decimal :rank_absolute

      t.timestamps null: false
    end

    add_foreign_key :requests, :draw_groups
    add_foreign_key :requests, :collections
  end
end
