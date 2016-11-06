class WatermarksController < ApplicationController
  before_filter :require_google_auth_user

  def new
    @watermark = Watermark.new
  end

  def create
    @watermark = Watermark.new(watermark_params)
    @watermark.user_id  = current_user.id
    if @watermark.save
      redirect_to watermark_path(@watermark)
    else
      render :new
    end
  end

  def show
    @watermark = Watermark.find(params[:id])
    @sidekiq_jobs = @watermark.sidekiq_jobs || []
    gon.push({
      google_id: @watermark.google_id
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

  def watermark_params
    params.require(:watermark).permit(:google_id, :project_id)
  end
end
