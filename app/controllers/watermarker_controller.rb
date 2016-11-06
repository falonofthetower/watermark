class WatermarkerController < ApplicationController
  def apply
    @watermark = Watermark.find(params[:id])
    @watermark.update(text_param)
    @job_id = WatermarkWorker.perform_async(@watermark.id)
    SidekiqJob.create(job_id: @job_id, user: current_user, driveable_id: @watermark.id, driveable_type: @watermark.class.name)

    flash[:success] = "watermark being applied!"

    respond_to do |format|
      format.html { redirect_to watermark_path(@watermark) }
      format.js
    end
  end

  def percentage_done
    job_id = params[:job_id]
    @status = Sidekiq::Status::at(job_id)

    respond_to do |format|
      format.json {
        render :json => {
          :status => @status
        }
      }
    end
  end

  def text_param
    params.permit(:text)
  end
end
