class PagesController < ApplicationController
  def board
  	size = 3 if !params[:size]
  	size ||= params[:size].to_i
  	@board = JdlTictactoe::Board.new(size)
  end

  def update_move
  end
end
