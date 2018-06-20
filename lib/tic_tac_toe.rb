# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  # row wins 
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  # column wins
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  # diagonal wins
  [0,4,8], #top left to bottom right
  [2,4,6] #top right to bottom left
  ]
  
def display_board(board)
  current_board = [" #{board[0]} | #{board[1]} | #{board[2]} ","-----------"," #{board[3]} | #{board[4]} | #{board[5]} ","-----------", " #{board[6]} | #{board[7]} | #{board[8]} "]
  puts current_board
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, marker)
  board[index] = "#{marker}"
end

def position_taken?(board, index)
  taken = nil
  if (board[index] ==  " " || board[index] == "" || board[index] == nil)
   taken = false
  else
   taken = true
  end
  taken
end

def valid_move?(board, index)
  valid = nil
  # check to see if index is on the board
  if (index >= 0 && index <= 8)
    # check to see if space is already occupied
    if (position_taken?(board,index) == true)
      valid = false
    else
      valid = true
    end
  else 
    valid = false
  end
  valid
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)
  until valid_move?(board, index) == true do
    puts "Please enter 1-9:"
    user_input = gets
    index = input_to_index(user_input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0 
  board.each do |check|
    if (check["X"] || check["O"])
      counter += 1 
    end
  end
  counter
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end
  
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1= combo[0]
    win_index_2= combo[1]
    win_index_3= combo[2]
      
    position_1= board [win_index_1]
    position_2= board [win_index_2]
    position_3= board [win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    end
  end
  else
    false
end
  
def full?(board)
  board.all? do |check|
    check == "X" || check == "O"
  end
end
  
def draw?(board)
  if won?(board) == false && full?(board) == true 
    return true
  else
    return false
  end
end
  
def over?(board)
  won?(board) || draw?(board) 
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end