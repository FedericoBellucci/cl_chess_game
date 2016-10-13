require 'chess_board'

describe ChessBoard do
	let(:chess) { ChessBoard.new }

	it { expect(chess.board).to be_kind_of(Array) }
	it { expect{ chess.show_board }.to output.to_stdout }

	describe "#move_piece" do
		context "moving knight from [b1] to [c3], c3 should be knight b1 should be empty square" do
			before do
				chess.move_piece("w" ,"b1", "c3")
			end
			it { expect(chess.board[2][2]).to eql("\u2658") }
			it { expect(chess.board[0][1]).to eql("\u2610") }
		end
		context "moving pawn from [a7] to [a5] moves pawn" do
			before do
				chess.move_piece("b", "a7", "a5")
			end
			it { expect(chess.board[4][0]).to eql("\u265f")}
			it { expect(chess.board[6][0]).to eql("\u2610")}
		end
		context "moving rook from [a1] to [a3] returns false" do
			it {expect(chess.move_piece("w", "a1", "a3")).to be false }
		end
		context "returns false if white turns tries to move black piece" do
			it { expect(chess.move_piece("w", "a7", "a5")).to be false }
		end
		context "returns false if black turn tries to move white piece" do
			it { expect(chess.move_piece("b", "a2", "a3")).to be false }
		end
		context "returns false if space requested is empty" do
			it { expect(chess.move_piece('w', "a4", "a5")).to be false}
		end
	end
end






