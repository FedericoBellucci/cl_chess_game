module ChessTools
  def position # turns the grid value into the true board array coordinate row/index
    placement = %w(a b c d e f g h)
    coordinate = self.split('')
    coordinate[1] = coordinate[1].to_i - 1
    placement.each_with_index { |x, i| coordinate[0] = i if coordinate[0] == x }
    coordinate[0], coordinate[1] = coordinate[1], coordinate[0]
  end

  def to_unicode(color)
    case self
    when 'r'
      if color == 'w'
        "\u2656"
      else
        "\u265c"
      end
    when 'b'
      if color == 'w'
        "\u2657"
      else
        "\u265d"
      end

    when 'q'
      if color == 'w'
        "\u2655"
      else
        "\u265b"
      end

    when 'k'
      if color == 'w'
        "\u2658"
      else
        "\u265e"
      end
    end
  end

  def enemy_king(color)
    piece = self.ord
    case piece
    when 9812
      return true if color == 'w'
    when 9818
      return true if color == 'b'
    end
    false
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
