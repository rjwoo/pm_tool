require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:project) { FactoryGirl.create(:project) }

  describe "#new" do
    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, project: FactoryGirl.attributes_for(:project)
      end

      it "creates a new project in the database" do
        count_before = Project.count
        valid_request
        count_after = Project.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the project show page" do
        valid_request
        expect(response).to redirect_to(project_path(Project.last))
      end

      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      def invalid_request
        post :create, project: {title: ""}
      end

      it "doesn't save a record to the database" do
        count_before = Project.count
        invalid_request
        count_after = Project.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    before do
      @project = FactoryGirl.create(:project)
      get :show, id: @project.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "sets an instance variable to the project with the passed id" do
      expect(assigns(:project)).to eq(@project)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "sets 'project' instance variable to all projects in the database" do
      project_1 = FactoryGirl.create(:project)
      project_2 = FactoryGirl.create(:project)
      get :index
      expect(assigns(:projects)).to eq([project_1, project_2])
    end
  end

  describe "#edit" do
    before do
      get :edit, id: project.id
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end

    it "sets an instance variable to the campaign with the id passed" do
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "#update" do
    context "With valid attributes" do
      def valid_request
        patch :update, id: project.id, project: {title: "new valid title"}
      end

      it "updates the record in the database" do
        valid_request
        expect(response).to redirect_to(project_path(project))
      end

      it "redirects to the show page" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "With invalid attributes" do
      def invalid_request
        patch :update, id: project.id, project: {title: ""}
      end

      it "doesn't save the updated project to the database" do
        invalid_request
        expect(project.reload.title).to_not eq("")
      end

      it "renders the edit template" do
        invalid_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do

    let!(:project) { FactoryGirl.create(:project) }

    it "removes the record from the database" do
      count_before = Project.count
      delete :destroy, id: project.id
      count_after  = Project.count
      expect(count_before).to eq(count_after + 1)
    end

    it "redirects to the projects path" do
      delete :destroy, id: project.id
      expect(response).to redirect_to(projects_path)
    end
  end

end
