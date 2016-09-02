require 'gosu'
require './whackable_image.rb'
require './game_stats.rb'

class WhackARuby < Gosu::Window
  WINDOW_HEIGHT = 600
  WINDOW_WIDTH = 800

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    setup_new_game
  end

  def setup_new_game
    self.caption = "Whack the Ruby!"
    @game_stats = GameStats.new
    @background_color = Gosu::Color::BLACK
    @time_in_game = 100_000
    @start_time = Gosu.milliseconds
    setup_images
    setup_sounds
  end

  def setup_images
    @ruby_img = WhackableImage.new('./images/ruby.png')
    @hammer_img = Gosu::Image.new('./images/hammer.png')
    @game_over_img =
      Gosu::Image.from_text "Game Over \n Press Spacebar to Play Again",
                            50,
                            width: 400,
                            font: Gosu.default_font_name,
                            align: :center
  end

  def setup_sounds
    @music = Gosu::Song.new "./audio/chapter-2-this-book-is-made.mp3"
    @whack_sound = Gosu::Sample.new "./audio/positive.mp3"
    @miss_sound = Gosu::Sample.new './audio/negative.mp3'
    @music.volume = 0.1
    @music.play
  end

  def ruby_under_hammer?
    hammers_head_x = mouse_x - 29
    hammers_head_y = mouse_y - 15

    return true if Gosu.distance(
      hammers_head_x, hammers_head_y, @ruby_img.x_pos, @ruby_img.y_pos
    ) < 25 && @ruby_img.visibility > 0
    false
  end

  def handle_whacks
    if ruby_under_hammer?
      @game_stats.whacks += 1
      @background_color = Gosu::Color::GREEN
      @whack_sound.play
    else
      @game_stats.whacks -= 1
      @background_color = Gosu::Color::RED
      @miss_sound.play
    end
  end

  def color_window_background(color)
    Gosu.draw_rect(0, 0, width, height, color)
    @background_color = Gosu::Color::BLACK
  end

  def draw_images
    @ruby_img.draw(@ruby_img.x_pos, @ruby_img.y_pos, 1) if @ruby_img.visible?
    @hammer_img.draw(mouse_x - @hammer_img.width, mouse_y - 20, 2)
  end

  def draw_game_over_screen
    @game_over_img.draw WINDOW_WIDTH / 2 - @game_over_img.width / 2,
                        WINDOW_HEIGHT / 2 - @game_over_img.height / 2,
                        1
    Gosu.draw_rect(0, 0, width, height, Gosu::Color::BLUE)
    @game_stats.draw("Whacks: #{@game_stats.whacks}", 0, 0, 1)
  end

  def elapsed_time
    Gosu.milliseconds - @start_time
  end

  def time_up?
    @game_stats.time_remaining < 0
  end

  def button_down(id)
    handle_whacks if id == Gosu::MsLeft && !time_up?
    close if id == Gosu::KbEscape
    setup_new_game if time_up? && id == Gosu::KbSpace
  end

  def update
    @game_stats.time_remaining = (@time_in_game - elapsed_time) / 1000
    @ruby_img.calculate_visibility
    @ruby_img.calculate_position
  end

  def draw
    if @game_stats.time_remaining > 0
      @game_stats.draw_stats
      draw_images
      color_window_background @background_color
    else
      draw_game_over_screen
      @music.stop
    end
  end
end

window = WhackARuby.new

window.show
