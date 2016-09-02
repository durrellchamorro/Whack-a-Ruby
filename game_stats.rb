class GameStats < Gosu::Font
  attr_accessor :whacks, :time_remaining

  def initialize
    @whacks = 0
    super(20, name: Gosu.default_font_name)
  end

  def draw_stats
    draw("Whacks: #{whacks}", 0, 0, 1)
    draw("Time Left: #{time_remaining}", 600, 0, 1)
  end
end
