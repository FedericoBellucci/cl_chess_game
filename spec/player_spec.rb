require 'player'

describe Player do 
	let(:player) { Player.new("Rob", "white") }

	context "Returns name and color" do
		it { expect(player).to be_an_instance_of(Player) }
		it { expect(player.name).to eql("Rob") }
		it { expect(player.color).to eql("white") }
	end
end


