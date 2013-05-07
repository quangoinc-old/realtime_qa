class PusherController < ApplicationController
  def auth
    if current_user
      auth = Pusher[params[:channel_name]].authenticate(params[:socket_id],
        :user_id => current_user.id # => required
      )
      render :json => auth
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end