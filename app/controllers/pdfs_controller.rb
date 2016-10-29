require 'signet/oauth_2/client'

class PdfsController < ApplicationController
  before_action :require_user

  def new
    @email = User.find(session[:user_id]).email
    @pdf = Pdf.new
  end

  def create
    @pdf = Pdf.new(pdf_params)
    @pdf.user_id  = current_user.id
    if @pdf.save
      redirect_to pdf_path(@pdf)
    else
      render :new
    end
  end

  def show
    @pdf = Pdf.find(params[:id])
    @sidekiq_jobs = @pdf.sidekiq_jobs || []

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

  def pdf_params
    params.require(:pdf).permit(:file_id, :project_id)
  end
end

