require_relative 'player'
require_relative 'chess_board'
require 'yaml'

class ChessGame 

  def initialize
    load if Dir.glob("bin/*").size > 0
    @players = whos_playing?
    @board = ChessBoard.new
    @turn = 0
    @hor_guide = ("a".."h").to_a
    @ver_guide = ("1".."8").to_a
    instructions
  end

  def board
    @board.show_board
    puts "CHECK!" if @board.check
    if @board.checkmate
      puts "CHECKMATE!"
      puts "#{@players[@turn].name} Lost."
    else
      play
    end
  end
  def play
    piece_from = ""
    piece_to = ""
    puts "** It is #{@players[@turn].name}'s turn **"
    begin
      print "Choose the piece you wish to move: "
      piece_from = gets.strip
      if piece_from == 'save'
        save
      end
    end until @hor_guide.include?(piece_from[0]) && @ver_guide.include?(piece_from[1])

    begin
      print "Choose destination: "
      piece_to = gets.chomp
    end until @hor_guide.include?(piece_to[0]) && @ver_guide.include?(piece_to[1])
    if @board.move_piece(@players[@turn].color, piece_from, piece_to) == true
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
    puts "* Type 'save' anytime before choosing a move to save the game."
    puts "	GOOD LUCK! "
    board
  end
  
  def save
    print "Name the file you want to save: "
    file_name = gets.strip.downcase.split(" ").join("_")
    if File.exists?("bin/#{file_name}.yaml")
      puts "That file name already exist!"
      save
    else
      saving = File.open("bin/#{file_name}.yaml", 'w')
      saving.write(YAML::dump(self))
      exit
    end
  end
  
  def load
    puts "You have saved games, choose from the list to load a game or type 'new' for a new game."
    Dir.entries("bin").each { |f| puts f.split(".yaml"); puts ""}
    file_name = gets.strip.downcase
    if file_name == 'new'
      puts "New Chess Game"
    elsif File.exists?("bin/#{file_name}.yaml")
      saved_game = File.open("bin/#{file_name}.yaml", 'r') { |file| file.read }
      game = YAML.load saved_game
      game.board
    else
      puts "The file you requested does not exits!"
      load
    end
  end
end
ChessGame.new
