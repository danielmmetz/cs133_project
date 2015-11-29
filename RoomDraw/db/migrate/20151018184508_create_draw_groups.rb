class CreateDrawGroups < ActiveRecord::Migration
  def change
    create_table :draw_groups do |t|
      t.integer :student_id
      t.decimal :draw_num, precision: 10, scale: 5
      t.boolean :for_suite
      t.timestamps null: false
    end

    # add the id for the student representative.
    add_foreign_key :draw_groups, :students, name: :rep_id

  end
end
