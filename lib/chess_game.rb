require_relative 'player'
require_relative 'chess_board'

class ChessGame 

	def initialize
		@players = whos_playing?
		@board = ChessBoard.new
		@turn = 0
		instructions
		play
	end

	def play
		@board.show_board
		puts "** It is #{@players[@turn].name}'s turn **"
		print "Choose the piece you wish to move: "
		piece_from = gets.strip
		print "\nChoose destination: "
		piece_to = gets.strip
		@turn == 0 ? @turn = 1 : @turn = 0
		play
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
	end
end
ChessGame.new
