class ImagesController < ApplicationController
  before_filter :require_google_auth_user

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    @image.user_id  = current_user.id
    if @image.save
      redirect_to image_path(@image)
    else
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
    @sidekiq_jobs = @image.sidekiq_jobs || []
    gon.push({
      google_id: @image.google_id
    })

=begin
    if @sidekiq_jobs
      gon.watch.push({ job_id: @sidekiq_jobs.job_id })
    end
=end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def image_params
    params.require(:image).permit(:google_id, :project_id)
  end
end
