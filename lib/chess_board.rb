require_relative 'chess_tools'
include ChessTools

class ChessBoard	
	attr_reader :board

	def initialize
		@board = populate_board
		@grid_guide = ["a", "b", "c", "d", "e", "f", "g", "h"]
	end

	def move_piece(from, to)
	end

	def valid_move?(piece, to)
		piece_from = get_coordinates(piece)
		piece_to = get_coordinates(to)
		which_piece = ""
		@board[piece_from[0]].each_with_index { |x, i|  which_piece = x if i == piece_from[1] }
		case which_piece
		when "\u2658", "\u265e"
			return true if knight_possible_moves(piece_from).include?(piece_to)
		else
			return false
		end
		return false
	end

	def get_coordinates(grid_code)
		array_coordinate = grid_code.position #function from ChessTools
	end

	def populate_board
		@board = [["\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"], 
							Array.new(8, "\u2610"), 
							Array.new(8, "\u2610"), 
							Array.new(8, "\u2610"), 
							Array.new(8, "\u2610"), 
							Array.new(8, "\u2610"), 
							Array.new(8, "\u2610"), 
							["\u265c", "\u265e", "\u265d", "\u265b", "\u265a", "\u265d", "\u265e", "\u265c"]]

		@board.each_with_index { |row, i| 
		case i
		when 1
			(0...row.size).each { |i| row[i] = "\u2659" } #Populate white pawns
		when 6
			(0...row.size).each { |i| row[i] = "\u265f" } #Populate black pawns
		end
		}
	end

	def show_board
		puts ""
		print_guide
		@board.reverse.each_with_index { |row, i| print "#{8 - i} #{row} #{8 - i}\n\r\n" }
		print_guide
	end

	def print_guide
		@grid_guide.each { |x| print "    #{x}" }
		puts ""
	end

	def knight_possible_moves(position)
		directions = [[-1, 1],[-2, 2]] #2 pairs of numbers that make up the combinations of the way knight moves.
		moves = []
		possible_ones = []
		directions[0].each { |i| directions[1].each{|j| moves << [position[0]+i,position[1]+j] }} #Generates the first 4 combinations
		directions[1].each { |j| directions[0].each{|i| moves << [position[0]+j,position[1]+i] }} #Generates the remaining 4 combination
		moves.each { |x| possible_ones << x unless (x[0] < 0 || x[1] < 0) || (x[0] > 7 || x[1] > 7) } #Discards the moves that go off the board.
		return possible_ones
	end
end










