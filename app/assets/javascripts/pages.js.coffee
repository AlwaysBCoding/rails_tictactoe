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
		player1: {
			species: "human"
			mark: "X"
		}
		player2: {
			species: "human"
			mark: "O"
		}
	}

	drop_config_modal = ->
		$("#config").modal()

	initialize_game = ->
		game.player1.mark = $("#player1-mark").val()
		game.player2.mark = $("#player2-mark").val()
		game.player1.species = $(".player-species:checked")[0].value
		game.player2.species = $(".player-species:checked")[1].value
		initialize_squares()

	initialize_squares = ->
		_.each $(".square"), (item, index) ->
				game.board.squares.push (index + 1)

	update_move = ($square) ->
			id = parseInt $square.attr("id"), 10
			index = _.indexOf(game.board.squares, id)
			$square.addClass("selected")

			if game.turn == "player1"
				game.board.squares[index] = game.player1.mark
				$square.append("<p class='mark1'>" + game.player1.mark + "</p>")
			else if game.turn == "player2"
				game.board.squares[index] = game.player2.mark
				$square.append("<p class='mark2'>" + game.player2.mark + "</p>")

			$square.find("p").animate(opacity: 1, 500)

			if game.turn == "player1"
				$.post "/update_move", { game: game }

			game.turn = game.switch_turn()

	$(".square").on "click", (e) ->
		$square = $(e.target)
		unless $square.hasClass("selected") || $square.context.nodeName == "P"
			update_move($square)

	$("#config").on "hide", ->
		initialize_game()

	$(".play-again").on "click", ->
		window.location.reload(true)

	setTimeout (->
	  drop_config_modal()
	), 300

