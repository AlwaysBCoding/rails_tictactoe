$ ->
	game = {
		board: {
			size: Math.sqrt($(".square").length)
			squares: []
		}
		turn: "player1"
		switch_turn: ->
			return "player2" if game.turn == "player1"
			return "player1" if game.turn == "player2"
	}

	initialize_squares = ->
	_.each $(".square"), (item, index) ->
			game.board.squares.push (index + 1)

	initialize_game = ->
		console.log "SOMETHING"

	initialize_squares()

	update_move = ($square) ->
			id = parseInt $square.attr("id"), 10
			index = _.indexOf(game.board.squares, id)
			$square.addClass("selected")

			if game.turn == "player1"
				game.board.squares[index] = "X"
				$square.append("<p class='mark1'>X</p>")
			else if game.turn == "player2"
				game.board.squares[index] = "O"
				$square.append("<p class='mark2'>O</p>")

			$square.find("p").animate(opacity: 1, 500)

			if game.turn == "player1"
				$.post "/update_move", { game: game }

			game.turn = game.switch_turn()

	$(".square").on "click", (e) ->
		$square = $(e.target)
		unless $square.hasClass("selected") || $square.context.nodeName == "P"
			update_move($square)
