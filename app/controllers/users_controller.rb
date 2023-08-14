class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    
    @tracked_stocks = current_user.stocks
    @tracked_stocks = [] if @tracked_stocks.nil?  # Ensure it's an empty array if nil
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
  if params[:friend].present?
    friend_name = params[:friend].downcase
    @friends = User.search(friend_name)
    @friends = current_user.except_current_user(@friends)
    if @friends.any?
      render 'friends/search_result', friends: @friends
    else
      flash[:alert] = "No friend found with the provided name"
      redirect_to my_friends_path
    end
  else
    flash[:alert] = "Please enter a friend's name to search"
    redirect_to my_friends_path
  end
end

def my_friends
  @tracked_friends = current_user.friends || []
end


end
