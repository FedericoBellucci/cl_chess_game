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

 def enemy_king(color)
   piece = self.ord
   case piece
   when 9812
     if color == "w"
       return true
     end
   when 9818
     if color == "b"
       return true
     end
   end
   return false
 end

 def color
   case self.ord
   when 9812, 9813, 9814, 9815, 9816, 9817
     return 'w'
   when 9818, 9819, 9820, 9821, 9822, 9823
     return 'b'
   end
 end
end





