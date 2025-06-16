require "rails_helper"

RSpec.describe ProjectsController, type: :controller do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization: organization) }
  let(:project) { create(:project, organization: organization) }

  before do
    sign_in user
    ActsAsTenant.current_tenant = organization
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "shows a project" do
      get :show, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a project" do
      expect {
        post :create, params: {
          project: {
            title: "New Project",
            details: "Details here",
            expected_completion_date: Date.today + 7
          }
        }
      }.to change(Project, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the project" do
      project # create before expect
      expect {
        delete :destroy, params: { id: project.id }
      }.to change(Project, :count).by(-1)
    end
  end
end
