class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  
  WIN_COMBINATIONS = [
    [0,1,2]
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]]
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(@board, character = "X")
    board[index] = character
  end
  
  def position_taken?(@board, index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(@board, index)
    if index.between?(0, 8) && !position_taken?(@board, index)
      return true
    else
      return false
    end
  end
  
  def turn(@board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(@board, index)
      move(@board, index, current_player(@board))
      display_board(@board)
    else
      turn(@board)
    end
  end
 
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def won?(@board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3
      if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
      end
    end
  else
    false
  end

  def full?(@board)
    board.all? do |space|
      space == "X" || space == "O"
    end
  end

  def draw?(@board)
    if full?(@board) && !won?(@board)
      return true
    else
      false
    end
  end

  def over?(@board)
    if won?(@board) || draw?(@board) || full?(@board)
      return true
    end
  end

  def winner(@board)
    winning_token = won?(@board)
    if winning_token == false
      return nil
    elsif @board[winning_token[0]] == "X"
      return "X"
    elsif @board[winning_token[0]] == "O"
      return "O"
    end
  end

  def play(@board)
    until over?(@board)
      turn(@board)
    end
    if won?(@board) && winner(@board) == "X"
      puts "Congratulations X!"
    elsif won?(board) && winner(board) == "O"
      puts "Congratulations O!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end