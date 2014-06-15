class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_attributes)

    if @activity.save
      flash[:success] = "Activity successfully created."
      redirect_to @activity
    else
      render :new  
    end
  end

  def show
    @activity = Activity.find(params[:id])
  end

  private

  def activity_attributes
    params.require(:activity).permit(:name)
  end

end
