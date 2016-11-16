class WatermarkerController < ApplicationController
  def apply
    @old_image = Image.find(params[:id])
    new_id = current_user.google_id_pool.pop

    @new_image = Image.create(google_id: new_id, user: current_user, text: text_param[:text])
    @job_id = WatermarkWorker.perform_async(new_image: @new_image.id, old_image: @old_image.id)

    SidekiqJob.create(job_id: @job_id, user: current_user, driveable_id: @old_image.id, driveable_type: @old_image.class.name)

    flash[:success] = "watermark being applied!"

    respond_to do |format|
      format.html { redirect_to image_path(@new_image) }
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
