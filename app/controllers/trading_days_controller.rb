class TradingDaysController < ApplicationController
  def show
    @trading_day = TradingDay.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock }
    end
  end
end
