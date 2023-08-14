class FriendshipController < ApplicationController


  def destroy
    friendship = current_user.friendships.find_by(friend_id: params[:id])
    friendship.destroy!
    flash[:notice] = "Stopped following"
    redirect_to my_friends_path
  end

  def create
    friend = User.find(params[:id])
    friendship = current_user.friendships.build(friend_id: friend.id)

    if friendship.save
        flash[:notice] = "Following user"
      else
        flash[:alert] = "There was something wrong with tracking request"
      end
      redirect_to my_friends_path

  end

end
