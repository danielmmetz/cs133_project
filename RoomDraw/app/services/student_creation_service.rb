class StudentCreationService
  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @draw_num = params[:draw_num] + 10000
    @grad_year = params[:grad_year]

    s = Student.create id: @id, name: @name, draw_num: @draw_num, grad_year: @grad_year
    (DrawGroupCreationService.new rep_id: @id, suite?: false, mem_ids: [@id]).call
    return s
  end
end