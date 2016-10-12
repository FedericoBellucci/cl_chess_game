require_relative 'chess_tools'
include ChessTools

class ChessBoard	
	attr_reader :board

	def initialize			#rook 		#knight 	#bishop 	#queen 		#king 		#bishop 	#knight  	#rook
		@white_pieces = ["\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"]
		@black_pieces = ["\u265c", "\u265e", "\u265d", "\u265b", "\u265a", "\u265d", "\u265e", "\u265c"]
		@board = populate_board
	end

	def populate_board
		@board = [@white_pieces, 					#row 0
							Array.new(8, "\u2610"), #row 1
							Array.new(8, "\u2610"), #row 2
							Array.new(8, "\u2610"), #row 3
							Array.new(8, "\u2610"), #row 4
							Array.new(8, "\u2610"), #row 5
							Array.new(8, "\u2610"), #row 6
							@black_pieces]					#row 7

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
		("a".."h").each { |x| print "    #{x}" }
		puts ""
	end

	def move_piece(from, to)
		piece_from = from.position #function from ChessTools
		piece_to = to.position

		if valid_move?(piece_from, piece_to)
			@board[piece_from[0]][piece_from[1]], @board[piece_to[0]][piece_to[1]] = @board[piece_to[0]][piece_to[1]], @board[piece_from[0]][piece_from[1]]
		else
			puts "Invalid Move!"
		end
	end

	def identify_piece_in(position)
		identified_piece = ""
		@board[position[0]].each_with_index { |x, i|  identified_piece = x if i == position[1] }
		return identified_piece
	end

	def valid_move?(piece, to)
		piece_from = piece.position
		piece_to = to.position
		directions = []

		case identify_piece_in(piece_from)
		when "\u2658", "\u265e" 
			if knight_possible_moves(piece_from).include?(piece_to)
				directions = knight_possible_moves(piece_from)
			end
		when "\u2657", "\u265d"
			if bishop_possible_moves(piece_from).include?(piece_to)
				bishop_possible_moves(piece_from).each { |x| directions << x if bishop_possible_moves(piece_to).include?(x) }
			end
		when "\u2656", "\u265c" 
			if rook_possible_moves(piece_from).include?(piece_to)
				rook_possible_moves(piece_from).each { |x| directions << directions if rook_possible_moves(piece_to).include?(x) }
			end
		when "\u2655", "\u265b" 
			if queen_possible_moves(piece_from).include?(piece_to)
				queen_possible_moves(piece_from).each { |x| directions << directions if queen_possible_moves(piece_to).include?(x) }
			end
		when "\u2654", "\u265a"
			if king_possible_moves(piece_from).include?(piece_to)
				directions = king_possible_moves(piece_from)
			end
		when "\u2659", "\u265f"
			if pawn_possible_moves(piece_from).include?(piece_to)
			end
		end
		return directions
	end

	def friendly_blocking?(path)

	end

	def enemy_there?(destination)

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

	def white_pawn_possible_moves(position)

	end

	def black_pawn_possible_moves(position)

	end

	def bishop_possible_moves(position)
		row_u = position[0]
		row_d = position[0]
		indexr = position[1]
		indexl = position[1]
		possible_ones = []
		counter = 0
		while counter < 8
			row_u += 1
			row_d -= 1
			indexr += 1
			indexl -= 1
			possible_ones << [row_u, indexr] unless row_u > 8 || indexr > 7
			possible_ones << [row_u, indexl] unless row_u > 8 || indexl < 0
			possible_ones << [row_d, indexr] unless row_d < 0 || indexr > 7
			possible_ones << [row_d, indexl] unless row_d < 0 || indexl < 0
 			counter += 1
		end
		return possible_ones
	end

	def rook_possible_moves(position)
		possible_ones = []
		0.upto(7) { |x| possible_ones << [x, position[1]]; possible_ones << [position[0], x]}
		return possible_ones
	end

	def queen_possible_moves(position)
		possible_ones = rook_possible_moves(position) + bishop_possible_moves(position)
	end

	def king_possible_moves(position)
		row = position[0]
		column = position[1]
		possible_ones = []
		possible_ones << [row, column + 1] unless column > 7
		possible_ones << [row, column - 1] unless column < 0
		possible_ones << [row + 1, column] unless row > 7
		possible_ones << [row - 1, column] unless row < 0
	end
end










