class WhackableImage < Gosu::Image
  attr_accessor :x_pos, :y_pos, :visibility

  def initialize(location)
    @visibility = 0
    @visible_time = 75
    super location
    self.x_pos = random_x_position
    self.y_pos = random_y_position
  end

  def random_x_position
    rand WhackARuby::WINDOW_WIDTH - width
  end

  def random_y_position
    rand WhackARuby::WINDOW_HEIGHT - height
  end

  def calculate_position
    if visibility < 0
      self.x_pos = random_x_position
      self.y_pos = random_y_position
    end
  end

  def calculate_visibility
    self.visibility -= 1
    self.visibility = @visible_time if visibility < -10
  end

  def decrease_visible_time
    @visible_time -= 20
  end

  def visible?
    self.visibility > 0
  end

  def under_hammer?(window)
    hammers_head_x = window.mouse_x - 29
    hammers_head_y = window.mouse_y - 15

    return true if Gosu.distance(
      hammers_head_x, hammers_head_y, x_pos, y_pos
    ) < 25 && visibility > 0
    false
  end
end
