module ImageManipulations
  class RandomStamp
    attr_reader :magick, :randomizer
    attr_accessor :image, :random_stamp

    def initialize(magick, randomizer)
      @magick = magick
      @random_stamp = magick.open(randomizer.new.image_path)
    end

    def stamp(paths)
      self.image = magick.open(paths[:input])

      result = self.image.composite(self.random_stamp.resize(resize_string)) do |c|
        c.gravity "south"
      end
      result.write paths[:output]
    end

    def image_height
      self.image.dimensions.first
    end

    def image_width
      self.image.dimensions.last
    end

    def resize_string
      "#{image_height * 0.75}x#{image_width * 0.75}"
    end
  end
end
