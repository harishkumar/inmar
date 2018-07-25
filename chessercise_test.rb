require_relative "chessercise"
require "test/unit"

class TestChessercise < Test::Unit::TestCase
 
  def test_rook
    assert_equal("d8,d7,d6,d5,d4,d3,d1,a2,b2,c2,e2,f2,g2,h2",Chess.new("-piece","Rook","-position","d2").getMoves)
  end

  def test_queen
    assert_equal("e8,e7,e6,e4,e3,e2,e1,a5,b5,c5,d5,f5,g5,h5,d6,c7,b8,f6,g7,h8,d4,c3,b2,a1,f4,g3,h2",Chess.new("-piece","Queen","-position","e5").getMoves)
  end

  def test_knight
    assert_equal("c7,e7,b6,f6,b4,f4,c3,e3",Chess.new("-piece","Knight","-position","d5").getMoves)
  end
 
end