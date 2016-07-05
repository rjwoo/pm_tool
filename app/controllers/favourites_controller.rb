class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.find params[:project_id]
    favourite = Favourite.new(project: project, user: current_user)
    if favourite.save
      redirect_to project_path(project), notice: "Favourited!"
    else
      redirect_to project_path(project), alert: "Cannot Favourite!"
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    project = Project.find params[:project_id]
    favourite.destroy if can? :destroy, favourite
    redirect_to project_path(project), notice: "Unfavourited!"
  end
end
