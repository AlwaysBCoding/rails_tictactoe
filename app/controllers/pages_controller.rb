class PagesController < ApplicationController
  def board
  	size = 3 if !params[:size]
  	size ||= params[:size].to_i
  	@board = JdlTicTacToe::Board.new(size)
  end

  def update_move
  	@player1 = JdlTicTacToe::Player.new("human", params[:game][:player1][:mark])
  	@player2 = JdlTicTacToe::Player.new("computer", params[:game][:player2][:mark])
  	game = JdlTicTacToe::Game.new(@player1, @player2, params[:game][:board][:size].to_i)
  	params[:game][:board][:squares].each_with_index do |mark, index|
  		if mark.to_i == 0
  			game.mark_square(index+1, mark)
  		end
  	end

  	unless game.empty_squares.count == 0
	  	@response = @player2.minimax(game, params[:game][:switch_turn].to_sym)
	  	game.mark_square(@response, @player2.mark)
	  end

  	@loss = false
  	if game.over?
  		@gameOver = true
  		game.board.winner?(@player2.mark) ? @loss = true : @loss = false
  	else
  		@gameOver = false
  	end

  	render "computer_response"
  end
end
