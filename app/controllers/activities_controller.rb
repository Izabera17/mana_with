class ActivitiesController < ApplicationController
  def index
    @activities = current_user.active_notifications.page(params[:page]).per(20)
     @activities.where(checked: false).each do |activity|
      activity.update(checked: true)
    end
    @genres = Genre.all
  end
  
   def destroy_all
    #通知を全削除
    @activities = current_user.passive_notifications.destroy_all
  	redirect_to request.referer 
  end
end
