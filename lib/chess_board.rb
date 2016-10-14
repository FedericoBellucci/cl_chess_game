require_relative 'chess_tools'
include ChessTools

class ChessBoard	
	attr_reader :board

	def initialize			#rook 		#knight 	#bishop 	#queen 		#king 
		@white_pieces = ["\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2659"]
		@black_pieces = ["\u265c", "\u265e", "\u265d", "\u265b", "\u265a", "\u265f"]
		@board = populate_board
		@check = false
		@checkmate = false
		@promotion = false
	end

	def populate_board
		@board = [["\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"], 					#row 0
							Array.new(8, "\u2610"), #row 1
							Array.new(8, "\u2610"), #row 2
							Array.new(8, "\u2610"), #row 3
							Array.new(8, "\u2610"), #row 4
							Array.new(8, "\u2610"), #row 5
							Array.new(8, "\u2610"), #row 6
							["\u265c", "\u265e", "\u265d", "\u265b", "\u265a", "\u265d", "\u265e", "\u265c"]]					#row 7

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

	def move_piece(turn, from, to)
		piece_from = from.position #function from ChessTools
		piece_to = to.position
		piece = identify_piece_in(piece_from)
		return false if (turn == "w") && (@black_pieces.include?(piece))
		return false if (turn == "b") && (@white_pieces.include?(piece))
		return false if piece == "\u2610"
		if valid_move?(piece_from, piece_to, turn)
			make_move(piece_from, piece_to, turn) unless @promotion == true
			@promotion = false
			return true
		else
			return false
		end
	end


	def identify_piece_in(position)
		piece = @board[position[0]][position[1]]
	end
#TODO: implement castling, check, checkmate and promotion

private
	
	def make_move(from, to, turn)
		if enemy_there?(to, turn)
			@board[to[0]][to[1]] = @board[from[0]][from[1]]
			@board[from[0]][from[1]] = "\u2610"
		else
			@board[from[0]][from[1]], @board[to[0]][to[1]] = @board[to[0]][to[1]], @board[from[0]][from[1]]
		end
	end

	def complete_path(piece_from, piece_to)
		directions = []
		piece = identify_piece_in(piece_from)
		case piece
		when "\u2658", "\u265e" 
			if knight_possible_moves(piece_from).include?(piece_to) 
				directions = walk_this_way(piece_from, piece_to)
			end
		when "\u2657", "\u265d"
			if bishop_possible_moves(piece_from).include?(piece_to)
				directions = walk_this_way(piece_from, piece_to)
			end
		when "\u2656", "\u265c" 
			if rook_possible_moves(piece_from).include?(piece_to)
				directions = walk_this_way(piece_from, piece_to)
			end
		when "\u2655", "\u265b" 
			if queen_possible_moves(piece_from).include?(piece_to)
				directions = walk_this_way(piece_from, piece_to)
			end
		when "\u2654", "\u265a"
			if king_possible_moves(piece_from).include?(piece_to)
				directions = king_possible_moves(piece_from)
			end
		when "\u2659", "\u265f" #pawns
			if pawn_possible_moves(piece_from).include?(piece_to)
				if (piece == "\u2659" && piece_to[0] == 7)
					@promotion = true
					replace = choose_promotion('w')
					promotion(piece_from, piece_to, replace)
				elsif (piece == "\u265f" && piece_to[0] == 0)
					@promotion = true
					replace = choose_promotion('b')
					promotion(piece_from, piece_to, "\u265b")
				end
				directions = pawn_possible_moves(piece_from)
			end
		end
		return directions
	end

	def valid_move?(piece_from, piece_to, turn)
		path = complete_path(piece_from, piece_to)
		unless path.empty?
			return true if friendly_blocking?(path, turn) == false
		end
		return false
	end

	def friendly_blocking?(path, turn)
		path[1..-1].each { |coordinate| 
			square = identify_piece_in(coordinate)
			if turn == 'w'
				return true if @white_pieces.include?(square)
			else
				return true if @black_pieces.include?(square)
			end }
		return false 
	end

	def enemy_there?(destination, turn)
		space = identify_piece_in(destination)
		if turn == 'w'
			return true if @black_pieces.include?(space)
		else
			return true if @white_pieces.include?(space)
		end
		return false
	end

	def knight_possible_moves(position)
		directions = [[-1, 1],[-2, 2]] #2 pairs of numbers that make up the combinations of the way knight moves.
		moves = []
		possible_coordinates = []
		directions[0].each { |i| directions[1].each{|j| moves << [position[0]+i,position[1]+j] }} #Generates the first 4 combinations
		directions[1].each { |j| directions[0].each{|i| moves << [position[0]+j,position[1]+i] }} #Generates the remaining 4 combination
		moves.each { |x| possible_coordinates << x unless (x[0] < 0 || x[1] < 0) || (x[0] > 7 || x[1] > 7) } #Discards the moves that go off the board.
		possible_coordinates
	end

	def pawn_possible_moves(position)
		possible_coordinates = []
		row = position[0]
		column = position[1]
		if identify_piece_in(position) == "\u2659"
			possible_coordinates << [row+1, column]
			possible_coordinates << [row+2, column] if row == 1
			possible_coordinates << [row+1, column+1] if enemy_there?([row+1, column+1], "w")
			possible_coordinates << [row+1, column-1] if enemy_there?([row+1, column-1], "w") 
		else
			possible_coordinates << [row-1, column]
			possible_coordinates << [row-2, column] if row == 6
			possible_coordinates << [row-1, column-1] if enemy_there?([row-1, column-1], "b")
			possible_coordinates << [row-1, column+1] if enemy_there?([row-1, column+1], "b")
		end
		possible_coordinates
	end

	def choose_promotion(color)
		begin
			print "Choose a piece [q]ueen, [r]ook, [b]ishop, [k]night: "
			choice = gets.strip
		end until ['q','r','b','k'].include?(choice)
			choice.to_unicode(color)
	end

	def promotion(from, to, replace_with)
		@board[from[0]][from[1]] = "\u2610"
		@board[to[0]][to[1]] = replace_with
	end

	def bishop_possible_moves(position, counter=8 )
		row_u = position[0]
		row_d = position[0]
		indexr = position[1]
		indexl = position[1]
		possible_coordinates = []
		while counter > 0
			row_u += 1
			row_d -= 1
			indexr += 1
			indexl -= 1
			possible_coordinates << [row_u, indexr] unless row_u > 7 || indexr > 7
			possible_coordinates << [row_u, indexl] unless row_u > 7 || indexl < 0
			possible_coordinates << [row_d, indexr] unless row_d < 0 || indexr > 7
			possible_coordinates << [row_d, indexl] unless row_d < 0 || indexl < 0
 			counter -= 1
		end
		return possible_coordinates
	end

	def rook_possible_moves(position, counter=8)
		row_u = position[0]
		row_d = position[0]
		indexr = position[1]
		indexl = position[1]
		possible_coordinates = []
		while counter > 0
		row_u += 1
		row_d -= 1
		indexr += 1
		indexl -= 1
		possible_coordinates << [position[0], indexr] unless indexr > 7
		possible_coordinates << [position[0], indexl] unless indexl < 0
		possible_coordinates << [row_d, position[1]] unless row_d < 0
		possible_coordinates << [row_u, position[1]] unless row_u > 7
		counter -= 1
		end 
		possible_coordinates
	end

	def queen_possible_moves(position, all=true)
		if all
			possible_coordinates = rook_possible_moves(position) + bishop_possible_moves(position)
		else
			possible_coordinates = rook_possible_moves(position, 1) + bishop_possible_moves(position, 1)
		end
		possible_coordinates
	end

	def king_possible_moves(position)
		row = position[0]
		column = position[1]
		possible_ones = []
		possible_ones << [row, column + 1] unless column > 7
		possible_ones << [row, column - 1] unless column < 0
		possible_ones << [row + 1, column] unless row > 7
		possible_ones << [row - 1, column] unless row < 0
		possible_ones
	end
	
	def walk_this_way(root, destination) #Breadth first search method
		piece = identify_piece_in(root)
		current = Node.new(root)
		queue = [current]
		path = []
		found = false
		begin
			current_child = possible_moves(current.home, piece)
			current_child.each{ |x| queue << Node.new(x, current) }
			current = queue.shift

			if current.home == destination
				path << current.home
				#Adds up the chain to obtain the full path
				until current.parent.nil? 
				path << current.parent.home
				current = current.parent
				end
				path.reverse! #Reverses the array to show root as first one and destination as last one.
 				found = true
			end
		end until found == true
		return path 
	end

	def possible_moves(position, piece)
		possible = []
		case piece
		when "\u2658", "\u265e" 
			return knight_possible_moves(position)
		when "\u2657", "\u265d"
			return bishop_possible_moves(position, 1)
		when "\u2656", "\u265c" 
			return rook_possible_moves(position, 1)
		when "\u2655", "\u265b" 
			return queen_possible_moves(position, false)
		when "\u2654", "\u265a"
			return king_possible_moves(position, 1)
		when "\u265f", "\u2659" #black pawn
			return pawn_possible_moves(position, piece)
		end
	end
end

class Node
	attr_accessor :home, :parent

	def initialize(home, parent=nil)
		@home = home
		@parent = parent
	end
end







