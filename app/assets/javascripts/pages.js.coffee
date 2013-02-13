$ ->
	initialize_squares = ->
		_.each $(".square"), (item, index) ->
			board.squares.push (index + 1)

	board = {
		size: Math.sqrt($(".square").length)
		squares: []
	}

	initialize_squares()

	console.log board
