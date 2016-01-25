class Map

  def initialize(window)
    @window = window
    @tiles = [] #setup_tiles(window, rows, columns)
    @water_image = Image.new(window, "media/water.png", true)
    @grass_image = Image.new(window, "media/grass_block.png", true)
    @tile_specs   = {
      "W" => {:image => Image.new(window, "media/water.png",       true)  , :walkable => false },
      "#" => {:image => Image.new(window, "media/grass_block.png", true)  , :walkable => true  },
      "S" => {:image => Image.new(window, "media/stone_block.png", true)  , :walkable => true  },
      "D" => {:image => Image.new(window, "media/dirt_block.png",  true)  , :walkable => true  },

      "l" => {:image => Image.new(window, "media/left.png",        true)  , :walkable => true  },
      "r" => {:image => Image.new(window, "media/right.png",       true)  , :walkable => true  },
      "x" => {:image => Image.new(window, "media/bottom.png",      true)  , :walkable => true  },
      "t" => {:image => Image.new(window, "media/top.png",         true)  , :walkable => true  },
      "m" => {:image => Image.new(window, "media/ringmat.png",     true)  , :walkable => true  },
      "a" => {:image => Image.new(window, "media/topleft.png",     true)  , :walkable => true  },
      "c" => {:image => Image.new(window, "media/topright.png",    true)  , :walkable => true  },
      "e" => {:image => Image.new(window, "media/bottomleft.png",  true)  , :walkable => true  },
      "f" => {:image => Image.new(window, "media/bottomright.png", true)  , :walkable => true  },
      "F" => {:image => Image.new(window, "media/floor.png", true)  , :walkable => true  },
    }
  end

  def draw
    @tiles.each{|t| t.draw }
  end

  def add_tile(row, column, type)
    tile_spec = if @tile_specs.keys.include?(type)
      @tile_specs[type]
    else
      @tile_specs["m"]
    end
    @tiles << Tile.new(@window, row, column, tile_spec[:image], tile_spec[:walkable])
  end

  def walkable?(hit_box)
    blocked = @tiles.any? do |tile|
      tile.blocked?(hit_box)
    end
    !blocked
  end

end
