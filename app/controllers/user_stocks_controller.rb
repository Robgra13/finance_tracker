class UserStocksController < ApplicationController
  def create
    stock_info = Stock.new_lookup(params[:ticker])
     if stock_info
        stock = Stock.find_by_ticker(stock_info[:ticker])
        @user_stock = UserStock.create(user: current_user, stock: stock)
        flash[:notice] = "Stock #{stock.name} was successfully added yo your portfolio"
        redirect_to my_portfolio_path
        return
        else
        flash[:alert] = "Unable to find stock with ticker #{params[:ticker]}"
      end
   redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker.upcase} was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end

end
