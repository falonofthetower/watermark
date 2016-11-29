require 'spec_helper'

describe ImageManipulations do
  describe ImageManipulations::RandomStamp do
    describe "trump_stamp" do
      let(:fake_image) { double("MiniMagick::Image", dimensions: [100, 100]) }
      let(:random_stamp) { double("RandomPuppy", dimensions: [200, 200], image_path: "fake_path") }
      let(:magick) { class_double("MiniMagick::Image") }
      let(:randomizer) { double("RandomPuppy") }
      let(:new_stamp) { double("MiniMagick::Image") }
      let(:composite) { double }

      it "reduces the stamp to half the size of the image" do
        expect(randomizer).to receive(:new).and_return(random_stamp)
        expect(magick).to receive(:open).with("fake_path").and_return(random_stamp)
        expect(magick).to receive(:open).with("image_path").and_return(fake_image)
        expect(random_stamp).to receive(:resize).with("75.0x75.0").and_return(new_stamp)
        expect(fake_image).to receive(:composite).with(new_stamp).and_yield(c = double).and_return(composite = double)
        expect(c).to receive(:gravity)
        expect(composite).to receive(:write).with("new_path")
        ImageManipulations::RandomStamp.new(magick, randomizer).stamp(
          input: "image_path",
          output: "new_path"
        )
      end
    end
  end
end
