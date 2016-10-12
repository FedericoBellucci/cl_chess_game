module ChessTools

	def position #turns the grid value into the true board array coordinate row/index
		placement = ["a", "b", "c", "d", "e", "f", "g", "h"]
		coordinate = self.split("")
		coordinate[1] = coordinate[1].to_i - 1
		placement.each_with_index { |x, i| coordinate[0] = i if coordinate[0] == x }
		coordinate[0], coordinate[1] = coordinate[1], coordinate[0]
	end
end