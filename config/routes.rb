JdlTictactoe::Application.routes.draw do
  root to: "pages#board"
  post "/update_move" => "pages#update_move", as: "update_move"
  get "pages/board"
end
