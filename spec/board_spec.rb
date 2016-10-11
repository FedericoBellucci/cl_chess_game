require 'chess_board'

describe ChessBoard do
	let(:chess) { ChessBoard.new }

	it { expect(chess.board).to be_kind_of(Array) }
	it { expect{ chess.show_board }.to output.to_stdout }

	describe "#get_coordinate" do
		context "turns the grid input 'b4' into the array coordinate: row 3 index 1" do
			it {expect(chess.get_coordinates("b4")).to eql([3, 1]) }
		end
	end
	describe "#valid_move" do
		context "moving the knight from [b1] to [c3] returns true" do
			it {expect(chess.valid_move?("b1","c3")).to be true}
		end
		context "moving the knight from [b1] to [c4] return false" do
			it {expect(chess.valid_move?("b1", "c4")).to be false}
		end
	end
	
	describe "#move_piece" do
		context "Moving a pawn first time should move two steps foward" do
		end
		context "Pawn moves one step foward" do
		end
		context "Knight moves two steps foward one step right" do
		end
		context "Bishop moves diagonally" do
		end
	end
end