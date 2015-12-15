namespace :draw do
  desc "Perform the automated draw"
  task :auto, [:year] => :environment do |t, args|
    occupy_gen = OccupyCreationService.new
    draw_order = Request.order :rank_absolute
    draw_order.each do |r|
      break if all_drawn? args[:year]
      occupy_gen.draw r, args[:year]
    end
  end
end

def all_drawn?(year)
  (Occupy.where academic_year: year).count ==
    Student.where("grad_year > #{year} AND NOT is_absent").count
end