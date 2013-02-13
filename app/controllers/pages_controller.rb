class PagesController < ApplicationController
  def board
  	@board = JdlTictactoe::Board.new(6)
  end

  def update_move
  end
end
