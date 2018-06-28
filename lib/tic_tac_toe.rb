#WIN_COMBINATIONS CONSTANT
WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], #Right column
  [0, 4, 8], #Diagonal
  [2, 4, 6] #Diagonal
  ]
  
#display_board
def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "] )
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index
def input_to_index(index)
  index = index.to_i
  if index == 0
    -1
  else
    index - 1
  end
end

#move
def move(board, index, token)
  board[index] = token
end

#position_taken?
def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == NIL
    false
  else 
    TRUE
  end  
end

#valid_move?
def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    TRUE
  else
    false
  end
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  user_index = gets
  user_index = input_to_index(user_index)
  if valid_move?(board, user_index)
    move(board, user_index, current_player(board))
    board
  else
    turn(board)
  end
end

#turn_count
def turn_count(board)
  counter = 0
  board.each do |token|
    if token =="X" || token =="O"
      counter += 1
    end
  end
  counter
end

#current_player
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#won?
def won?(board)
  winning_board = false
  WIN_COMBINATIONS.each do |win_combo|
    test_board = []
    win_combo.each do |win_index|
      test_board << board[win_index]
    end
    if test_board.all? {|token| token == "X"} || test_board.all? {|token| token == "O"} 
      winning_board = win_combo
    end
  end
  winning_board
end

#full?
def full?(board)
  board.all? {|position| position =="X" || position =="O"}
end

#draw?
def draw?(board)
  !won?(board) && full?(board)
end

#over?
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#winner
def winner(board)
  winning_combo = won?(board)
  if winning_combo
    board[winning_combo[0]]
  else
    nil
  end
end

#play
def play(board)
  until over?(board)
    board = turn(board)
    display_board(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else 
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  end
end