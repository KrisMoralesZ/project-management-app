require "rails_helper"

RSpec.describe "Projects", type: :request do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization: organization) }
  let!(:project) { create(:project, organization: organization) }

  before do
    sign_in user
    ActsAsTenant.current_tenant = organization
  end

  # describe "GET /projects" do
  #   it "works!" do
  #     get projects_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  #
  # describe "POST /projects" do
  #   it "creates a new project" do
  #     expect {
  #       post projects_path, params: {
  #         project: {
  #           title: "API Test",
  #           details: "From request spec",
  #           expected_completion_date: 2.weeks.from_now
  #         }
  #       }
  #     }.to change(Project, :count).by(1)
  #   end
  # end
  #
  # describe "DELETE /projects/:id" do
  #   it "destroys the project" do
  #     expect {
  #       delete project_path(project)
  #     }.to change(Project, :count).by(-1)
  #   end
  # end
end
