# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  # ETC, an array for each win combination
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} " 
end 

def input_to_index(user_input)
  index = user_input.to_i - 1
  return index
end

def move(board,index, token)
  board[index] = token
end

def valid_move?(board, index)
  if !(index.between?(0,8))
    return false
  elsif position_taken?(board,index) == true
    return false
  elsif position_taken?(board,index) == false && index.between?(0,8)
    return true
  end
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)
  if valid_move?(board,index)
    move(board,index, current_player(board))
    display_board(board)
  elsif !(valid_move?(board,index))
    while !(valid_move?(board,index))
      print "Please enter a valid move 1-9:"
      user_input = gets
      index = input_to_index(user_input)
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  elsif turn_count(board) % 2 != 0 
    return "O"
  end
end

def won?(board)
  won_check = 0
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2] 
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
      won_check +=1
      break
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
      won_check +=1
      break
    end
  end
  if won_check == 0
    return false
  end
end


def full?(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
      counter +=1
    end
  end
  if counter == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board) != false
    return false
  elsif !(full?(board))
    return false
  elsif full?(board) && !(won?(board))
    return true
  end
end

def over?(board)
  if won?(board)
    return true
  elsif full?(board)
    return true
  elsif draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    winning_board = won?(board)
    return board[winning_board[1]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
    if won?(board)
      break
    elsif draw?(board)
      puts "Cat's Game!"
      break
    end
  end
  if draw?(board) == true
    puts "Cat's Game!"
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end
end
