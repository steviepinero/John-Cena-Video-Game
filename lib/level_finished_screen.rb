class LevelFinishedScreen

  def initialize(window)
    @window = window
    @title = Image.new(
      @window,
      "media/win.jpg"

    )
  end

  def draw
    @title.draw(0,0,0)
  end

  def update ; end

  def button_down(id)
    @window.show_next_level
  end

end
