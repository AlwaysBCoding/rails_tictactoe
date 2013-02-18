class PagesController < ApplicationController
  def board
  	size = 3 if !params[:size]
  	size ||= params[:size].to_i
  	@board = JdlTicTacToe::Board.new(size)
  end

  def update_move
  	player1 = JdlTicTacToe::Player.new("human", "X")
  	@player2 = JdlTicTacToe::Player.new("computer", "O")
  	game = JdlTicTacToe::Game.new(player1, @player2, params[:game][:board][:size].to_i)
  	turn = :player1
  	params[:game][:board][:squares].each_with_index do |mark, index|
  		if mark.to_i == 0
  			game.mark_square(index+1, mark)
  		end
  	end
  	@response = @player2.minimax(game, :player2)
  	game.mark_square(@response, @player2.mark)
  	if game.over?
  		@gameOver = true
  	else
  		@gameOver = false
  	end
  	render "computer_response"
  end
end
