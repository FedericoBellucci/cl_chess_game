require_relative 'player'
require_relative 'chess_board'

class ChessGame 

	def initialize
		@players = whos_playing?
		@board = ChessBoard.new
		@turn = 0
		@hor_guide = ("a".."h").to_a
		@ver_guide = ("1".."8").to_a
		instructions
	end

	def board
		@board.show_board
		play
	end
	def play
		piece_from = ""
		piece_to = ""
		puts "** It is #{@players[@turn].name}'s turn **"
		begin
			print "Choose the piece you wish to move: "
			piece_from = gets.strip
		end until @hor_guide.include?(piece_from[0]) && @ver_guide.include?(piece_from[1])

		begin
			print "Choose destination: "
			piece_to = gets.chomp
		end until @hor_guide.include?(piece_to[0]) && @ver_guide.include?(piece_to[1])
	
		if @board.move_piece(@players[@turn].color, piece_from, piece_to)
			@turn == 0 ? @turn = 1 : @turn = 0
		else
			puts "Invalid move"
		end
		board
	end

	def whos_playing?
		print "Name of the first player: "
		name1 = gets.strip
		begin
			print "\nSelect your color, [w]hite or [b]lack: "
			color1 = gets.downcase.strip
		end until color1 == 'b' || color1 == 'w'

 		print "\nName of the second player: "
		name2 = gets.strip
		if color1 == 'w'
			color2 = "b"
			players = [Player.new(name1, color1), Player.new(name2, color2)]
		else
			color1 = "b"
			color2 = "w"
			players = [Player.new(name2, color2), Player.new(name1, color1)]
		end
	end
	def instructions
		puts " _____________________________________ "
		puts "| Welcome! Chess Game in Command Line |"
		puts " ------------------------------------- "
		puts ""
		puts "* Each turn the game will show whos turn is it."
		puts "* The player must choose a valid piece to move considering the grid (e.g. 'a2')"
		puts "* The player must then choose where he wished to move that piece (e.g. 'a3')"
		puts "	GOOD LUCK! "
		board
	end
end
ChessGame.new
