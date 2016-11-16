require 'spec_helper'

describe ImagesController do
  describe "GET new" do
    it_behaves_like "requires google auth" do
      let(:action) { get :new }
    end

    it "sets @image" do
      allow_any_instance_of(DriveGenerator).to receive(:access_token)
      set_current_google_user
      get :new
      expect(assigns(:image)).to be_instance_of(Image)
    end
  end
end


#   describe "POST create" do
#     context "with valid input" do
#       let(:google_user) { Fabricate(:google_user)}

#       before do
#         project_creation = instance_double("project_creation", create: true)
#         expect(FileCreation).to receive(:new).and_return(project_creation)
#         expect(project_creation).to receive(:create)
#         set_current_google_user(google_user)
#         post :create, project: { name: "Space Bear" }
#       end

#       it "redirects to the projects index" do
#         expect(response).to redirect_to projects_path
#       end

#       it "creates a new project" do
#         expect(Project.count).to eq(1)
#       end

#       it "sets the success message" do
#         expect(flash[:success]).to be_present
#       end
#     end

#     context "with invalid input" do
#       let(:google_user) { Fabricate(:google_user)}
#       before do
#         set_current_google_user(google_user)

#         post :create, project: {
#           name: ""
#         }
#       end

#       it "renders the new template again" do
#         expect(response).to render_template :new
#       end

#       it "does not create a new project" do
#         expect(Project.count).to eq(0)
#       end

#       it "sets the failure message" do
#         expect(flash[:danger]).to be_present
#       end
#     end
#   end
