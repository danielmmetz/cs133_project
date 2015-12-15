class CreateOccupies < ActiveRecord::Migration
  def change
    create_table :occupies do |t|
      t.integer :draw_group_id
      t.integer :collection_id
      t.integer :academic_year
      t.boolean :in_fall?
      t.boolean :in_spring?

      t.timestamps null: false
    end

    add_foreign_key :occupies, :draw_groups
    add_foreign_key :occupies, :collections
  end
end
