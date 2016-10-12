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
		context "moving the knight from [b1] to [c4] returns false" do
			it {expect(chess.valid_move?("b1", "c4")).to be false}
		end
		context "moving the bishop from [c1] to [h6] returns true" do
			it {expect(chess.valid_move?("c1", "h6")).to be true }
		end
		context "moving the bishop from [c1] to [c3] returns false" do
			it {expect(chess.valid_move?("c1", "c3")).to be false}
		end
		context "moving the rook from [a1] to [a4] returns true" do
			it {expect(chess.valid_move?("a1", "a4")).to be true}
		end
		context "moving the rook from [a1] to [b4] returns false" do
			it {expect(chess.valid_move?("a1", "b4")).to be false}
		end
		context "moving queen from [d1] to [d4] returns true" do
			it {expect(chess.valid_move?("d1", "d4")).to be true}
		end
		context "moving queen from [d1] to [e2] returns true" do
			it {expect(chess.valid_move?("d1", "e2")).to be true}
		end
		context "moving queen from [d1] to [e3] returns false" do
			it {expect(chess.valid_move?("d1", "e3")).to be false}
		end
		context "moving king from [e1] to [e2] returns true" do
			it {expect(chess.valid_move?("e1", "e2")).to be true }
		end
		context "moving king from [e1] to [d2] returns false" do
			it {expect(chess.valid_move?("e1", "d2")).to be false}
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