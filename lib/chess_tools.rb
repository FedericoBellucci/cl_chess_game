module ChessTools

	def position #turns the grid value into the true board array coordinate row/index
		placement = ["a", "b", "c", "d", "e", "f", "g", "h"]
		coordinate = self.split("")
		coordinate[1] = coordinate[1].to_i - 1
		placement.each_with_index { |x, i| coordinate[0] = i if coordinate[0] == x }
		coordinate[0], coordinate[1] = coordinate[1], coordinate[0]
	end

	def to_unicode(color)
		case self
		when 'r'
			if color == 'w'
				return "\u2656"
			else
				return "\u265c"
			end
		when 'b'
			if color == 'w'
				return "\u2657"
			else
				return "\u265d"
			end
			
		when 'q'
			if color == 'w'
				return  "\u2655"
			else
				return "\u265b"
			end

		when 'k'
			if color == 'w'
				return "\u2658"
			else
				return "\u265e"
			end
		end 
	end
	
end