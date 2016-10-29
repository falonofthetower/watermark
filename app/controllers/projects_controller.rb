class ProjectsController < ApplicationController
  before_action :require_google_auth

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      FileCreation.new(@project).create

      redirect_to projects_path
      flash[:success] = "Project Created"
    else
      flash.now[:danger] = "Did you give the folder a name?"
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
