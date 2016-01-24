require 'RMagick'

class HealthBar
        attr_accessor :health, :x, :y, :z

        def initialize (window, width, height, max_health, starting_health, x, y, z, text = "", foreground_colour = 'green', border_colour = 'black', empty_callback)
                @window = window
                @width = width
                @height = height
                @max_health = max_health
                self.health = starting_health
                self.x = x
                self.y = y
                self.z = z
                @text = text
                @foreground = foreground_colour
                @border = border_colour
                @empty_callback = empty_callback
                @fixed_width = nil
        end

        def draw
                update_bar
                @bar.draw(self.x, self.y, self.z)
        end

        def update_bar
                @gc = Magick::Draw.new
                @gc.fill_opacity(0)
                @gc.stroke(@border)
                @gc.stroke_width(1)

                @gc.rectangle(0,0, @width, @height)

                @gc.fill_opacity(1)
                @gc.fill(@foreground)
                @gc.stroke(@foreground)
                @gc.stroke_width(1)
                @gc.rectangle(1,1, (@fixed_width == nil ? bar_width - 1 : @fixed_width), @height - 1)

                if @text.length > 0 then
                        @gc.fill('black')
                        @gc.stroke('black')
                        @gc.text(25, 15, @text)
                end
                background = Magick::Image.new(@width + 1, @height + 1)
                @gc.draw background
                @bar = Gosu::Image.new(@window, background, true)

                if @fixed_width == nil and bar_width == 1 then
                        @empty_callback.call()
                        @fixed_width = 1
                end
        end

        def bar_width
                w = Float(health) / Float(@max_health) * @width
                return (w > 0 ? w : 1)
        end
end
