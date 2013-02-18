JdlTictactoe::Application.routes.draw do
  root to: "pages#board"
  post "/update_move" => "pages#update_move", as: "update_move"
  post "/check_game_status" => "pages#check_game_status", as: "check_game_status"
  get "pages/board"
end
