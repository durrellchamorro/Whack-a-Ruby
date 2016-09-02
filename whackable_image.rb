class WhackableImage < Gosu::Image
  attr_accessor :x_pos, :y_pos, :visibility

  def initialize(location)
    @visibility = 0
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
    self.visibility = 70 if visibility < -10
  end

  def visible?
    self.visibility > 0
  end
end
