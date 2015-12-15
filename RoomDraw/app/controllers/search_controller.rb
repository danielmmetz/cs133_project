class SearchController < ApplicationController
  def show
  end

  def index
  end

  def create
    if params.has_key? :request
        request = params[:request]
        rcs = RequestCreationService.new
        req = rcs.create request[:group_id], request[:collection_id]
        if req.present?
          flash[:notice] = "You have added collection ##{request[:collection_id]} for group ##{request[:group_id]} to your queue."
        else
          flash[:error] = "Failed to add collection ##{request[:collection_id]} for group ##{request[:group_id]} to your queue."
        end
    end
    render :show
  end
end
