class ActivitiesController < ApplicationController
  def index
    @activities = current_user.active_notifications.page(params[:page]).per(20)
    @activities.where(checked: false).each do |activity|
     activity.update(checked: true)
    end
    @genres = Genre.all
  end
  
   def destroy_all
    @activities = current_user.active_notifications.destroy_all
    flash[:notice] = "アクティビティを削除しました"
  	 redirect_to request.referer 
  end
end
