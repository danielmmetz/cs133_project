class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      # unique id is implicitly defined

      t.string :name           # student's full name
      t.integer :draw_num      # the student's draw number
      t.integer :grad_year     # the year the student will graduate

      # The semester and year the student is going abroad
      t.boolean :is_absent, default: false

      t.timestamps null: false # adds created_at and updated_at columns
    end
  end
end
