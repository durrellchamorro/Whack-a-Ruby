class GameStats < Gosu::Font
  attr_accessor :whacks, :time_remaining, :level

  def initialize
    @whacks = 0
    super(20, name: Gosu.default_font_name)
  end

  def draw_stats
    draw("Whacks: #{whacks}", 0, 0, 1)
    draw("Time Left: #{time_remaining}", 685, 0, 1)
    draw("Level: #{level + 1}", 370, 0, 1)
  end
end
