class QueueController < ApplicationController
  def show
  end

  def index
  end

  def create
  end

  def destroy
    flash[:error] = "DESTROY -- destroy"
    (Request.find params[:req_id]).destroy
    render :show
  end

end
