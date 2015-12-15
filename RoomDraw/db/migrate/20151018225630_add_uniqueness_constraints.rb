class AddUniquenessConstraints < ActiveRecord::Migration
  def change
    # draw_num is unique to help against conflicts
    add_index :students, :draw_num, unique: true

    # rank_absolute is dependent on uniqueness, enforce it
    add_index :requests, :rank_absolute, unique: true

    # make the (draw_group_id, student_id) pair a key to Member
    add_index :members, [:draw_group_id, :student_id], unique: true

    # make the (dorm_name,room_num) pair a key to Room
    add_index :rooms, [:dorm_name,:room_num], unique: true

    # make the (student_id, academic_year, in_fall?, in_spring?) a key to Occupy
    add_index :occupies, [:draw_group_id, :academic_year, :in_fall?, :in_spring?], unique: true, name: 'index_occupies_on_student_year_fa_sp'
  end
end
