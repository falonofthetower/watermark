class RandomImage
  attr_reader :folder
  def initialize(folder)
    @folder = folder
  end

  def folder_path
    Rails.root.join("app/assets/images/#{folder}/").to_s
  end

  def image_path
    Dir.glob("#{folder_path}*.png").sample
  end
end
