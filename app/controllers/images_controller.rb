class ImagesController < ApplicationController
  before_action :require_google_auth_user

  def new
    set_access_token
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
    if @image.user == current_user

      @sidekiq_jobs = @image.sidekiq_jobs || []
      set_access_token
      gon.push({
        google_id: @image.google_id
      })

      # if @sidekiq_jobs
      #   gon.watch.push({ job_id: @sidekiq_jobs.job_id })
      # end

      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to root_path
    end
  end

  private

  def image_params
    params.require(:image).permit(:google_id, :project_id)
  end

  def set_access_token
    access_token = DriveGenerator.new(current_user.refresh_token).access_token
    @gon_items[:access_token] = access_token
    gon.push(@gon_items)
  end
end
