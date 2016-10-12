require 'chess_board'

describe ChessBoard do
	let(:chess) { ChessBoard.new }

	it { expect(chess.board).to be_kind_of(Array) }
	it { expect{ chess.show_board }.to output.to_stdout }

	describe "#valid_move" do
		context "moving the knight from [b1] to [c3] returns true" do
			it {expect(chess.valid_move?("b1","c3")).to be_an(Array)}
		end
		context "moving the knight from [b1] to [c4] returns false" do
			it {expect(chess.valid_move?("b1", "c4")).to be_empty}
		end
		context "moving the bishop from [c1] to [h6] returns true" do
			it {expect(chess.valid_move?("c1", "h6")).to be_an(Array) }
		end
		context "moving the bishop from [c1] to [c3] returns false" do
			it {expect(chess.valid_move?("c1", "c3")).to be_empty}
		end
		context "moving the rook from [a1] to [a4] returns true" do
			it {expect(chess.valid_move?("a1", "a4")).to be_an(Array)}
		end
		context "moving the rook from [a1] to [b4] returns false" do
			it {expect(chess.valid_move?("a1", "b4")).to be_empty}
		end
		context "moving queen from [d1] to [d4] returns true" do
			it {expect(chess.valid_move?("d1", "d4")).to be_an(Array)}
		end
		context "moving queen from [d1] to [e2] returns true" do
			it {expect(chess.valid_move?("d1", "e2")).to be_an(Array)}
		end
		context "moving queen from [d1] to [e3] returns false" do
			it {expect(chess.valid_move?("d1", "e3")).to be_empty}
		end
		context "moving king from [e1] to [e2] returns true" do
			it {expect(chess.valid_move?("e1", "e2")).to be_an(Array) }
		end
		context "moving king from [e1] to [d2] returns false" do
			it {expect(chess.valid_move?("e1", "d2")).to be_empty}
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