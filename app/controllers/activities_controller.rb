class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities
  end

  def new
    @activity = Activity.new
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = current_user.activities.new(activity_attributes)

    if @activity.save
      flash[:success] = "Activity successfully created."
      redirect_to @activity
    else
      render :new  
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = current_user.activities.find(params[:id])

    if @activity.update_attributes(activity_attributes)
      flash[:success] = "Activity successfully updated."
      redirect_to @activity
    else
      render :edit
    end
  end

  def destroy
    @activity = current_user.activities.find(params[:id]) 
    @activity.destroy
    flash[:notice] = "Activity successfully deleted."
    redirect_to activities_path
  end


  private

  def activity_attributes
    params.require(:activity).permit(:name)
  end

end
