class HomeController < ApplicationController
  def index
  end

  def search
    if params[:search].blank?
      flash[:notice] = "Please enter a search term"
    else
      @board =  Board.search_board(params[:search])
      @pin = Pin.search_pin(params[:search])
      if @board.nil? && @pin.nil?
        flash[:notice] = "No Results Found matching your query"
      else
        flash[:notice] = "Following are the search results"
        @search = @board + @pin
      end
    end
  end
end
