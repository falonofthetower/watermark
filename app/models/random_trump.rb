class RandomTrump
  def folder_path
    Rails.root.join('app/assets/images/trump/').to_s
  end

  def image_path
    Dir.glob("#{folder_path}*.png").sample
  end
end
