class SearchController < ApplicationController
  def show
  end

  def index
  end

  def create
    if params.has_key? :request
        request = params[:request]
        rcs = RequestCreationService.new
        rcs.create request[:group_id], request[:collection_id]
    end
    render :show
  end
end
