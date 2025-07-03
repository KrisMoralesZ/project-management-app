# spec/requests/artifacts_spec.rb
require 'rails_helper'

RSpec.describe "/artifacts", type: :request do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization: organization) }
  let(:project) { create(:project, organization: organization) }

  let(:valid_attributes) {
    {
      name: "Sample artifact",
      description: "Details about the artifact",
      project_id: project.id,
      creator_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      name: "", # invalid because it's blank
      description: "",
      project_id: nil,
      creator_id: nil
    }
  }

  let(:new_attributes) {
    {
      name: "Updated Artifact",
      description: "Updated description"
    }
  }

  before do
    ActsAsTenant.current_tenant = organization
    host! "#{organization.subdomain}.example.com"
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      project.artifacts.create! valid_attributes
      get project_artifacts_path(project)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      artifact = project.artifacts.create! valid_attributes
      get project_artifact_path(project, artifact)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_project_artifact_path(project)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      artifact = project.artifacts.create! valid_attributes
      get edit_project_artifact_path(project, artifact)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Artifact" do
        expect {
          post project_artifacts_path(project), params: { artifact: valid_attributes }
        }.to change(Artifact, :count).by(1)
      end

      it "redirects to the created artifact" do
        post project_artifacts_path(project), params: { artifact: valid_attributes }
        expect(response).to redirect_to(project_artifact_path(project, Artifact.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Artifact" do
        expect {
          post project_artifacts_path(project), params: { artifact: invalid_attributes }
        }.not_to change(Artifact, :count)
      end

      it "renders an unprocessable entity response" do
        post project_artifacts_path(project), params: { artifact: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested artifact" do
        artifact = project.artifacts.create! valid_attributes
        patch project_artifact_path(project, artifact), params: { artifact: new_attributes }
        artifact.reload
        expect(artifact.name).to eq("Updated Artifact")
      end

      it "redirects to the artifact" do
        artifact = project.artifacts.create! valid_attributes
        patch project_artifact_path(project, artifact), params: { artifact: new_attributes }
        expect(response).to redirect_to(project_artifact_path(project, artifact))
      end
    end

    context "with invalid parameters" do
      it "renders an unprocessable entity response" do
        artifact = project.artifacts.create! valid_attributes
        patch project_artifact_path(project, artifact), params: { artifact: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested artifact" do
      artifact = project.artifacts.create! valid_attributes
      expect {
        delete project_artifact_path(project, artifact)
      }.to change(Artifact, :count).by(-1)
    end

    it "redirects to the artifacts list" do
      artifact = project.artifacts.create! valid_attributes
      delete project_artifact_path(project, artifact)
      expect(response).to redirect_to(project_artifacts_path(project))
    end
  end
end
