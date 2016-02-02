#TODO add differnt wrestlers, change Opponent class to opponent class, Add health?
#                                       too lazy, staying "bug"


class Bug

  attr_reader :x, :y
  DIRECTIONS       = [:left, :right, :up, :down]

  def initialize(window, level, column, row)
    @window = window
    @level  = level
    @imagenumber = rand(4)
    @image  = Image.new(@window, "media/#{@imagenumber}.png", true)
    @width  = @image.width
    @height = @image.height
    @offset_y = 65
    @x = column * @image.width
    @y = row * 75 - @offset_y
    @direction = :down
    @walking_speed = rand(1..3)
  end

  def hit_box(x, y)
    {:x => x, :y => y + @offset_y, :width => @width, :height => 100}
  end

  def update
    if rand(1000) < 15
      change_direction
    else
      try_keep_walking
    end
  end

  def draw
    if @direction == :left
      @image.draw(@x,@y, 0, -1.0, 1.0)
    else
      @image.draw(@x,@y, 0)
    end
  end

  def try_keep_walking
    x, y = coordinates_to_continue_direction
    if fits?(x, y) && @level.map.walkable?(hit_box(x, y))
      @x = x
      @y = y
    else
      change_direction
    end
  end

  def change_direction
    @direction = (DIRECTIONS - [@direction]).sample
  end

  def coordinates_to_continue_direction
    case @direction
      when :down
          [@x, @y + @walking_speed]
      when :up
          [@x, @y - @walking_speed]
      when :left
          [@x - @walking_speed, @y]
      when :right
          [@x + @walking_speed, @y]
    end
  end

  def fits?(x, y)
    fits_horizontally?(x) && fits_vertically?(y)
  end

  def fits_horizontally?(x)
    x > -10 && x + @width < @window.width
  end

  def fits_vertically?(y)
    y > 0 - @offset_y && y + @height - @offset_y / 2 < @window.height
  end

end
