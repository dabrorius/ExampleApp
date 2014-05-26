require 'spec_helper'

describe TasksController do
  let(:current_user) { FactoryGirl.create(:user) }
  before { sign_in current_user }

  describe "#index" do
    it "returns only current user's tasks" do
      task1 = FactoryGirl.create(:task, user: current_user)
      task2 = FactoryGirl.create(:task)
      get :index
      assigns(:tasks).should =~ [task1]
    end
  end

  describe "#create" do
    it "creates new task" do
      expect { post :create, task: { description: "Feed the pigs"} }.
      to change{Task.count}.from(0).to(1)
      Task.last.user.should eq current_user
      Task.last.description.should eq "Feed the pigs"
    end
  end

  describe "#update" do
    let(:my_task) { FactoryGirl.create(:task, description: "Old description", user: current_user) }      
    let(:not_my_task) { FactoryGirl.create(:task, description: "Old description") }

    it "updates my task" do
      expect { patch :update, id: my_task.id, task: { description: "New description" } }.
      to change{my_task.reload.description}.from("Old description").to("New description")
    end

    it "does not update task that I don't own" do
      expect { patch :update, id: not_my_task.id, task: { description: "New description" } }.
      to_not change{ not_my_task.reload.description }
      response.status.should eq 401
    end
  end

  describe "#destroy" do
    let!(:my_task) { FactoryGirl.create(:task, description: "Old description", user: current_user) }      
    let!(:not_my_task) { FactoryGirl.create(:task, description: "Old description") }

    it "deletes my task" do
      expect { delete :destroy, id: my_task.id }.
      to change { Task.count }.from(2).to(1)
    end

    it "does not delete task that I don't own" do
      expect { delete :destroy, id: not_my_task.id }.
      to_not change{ Task.count }
      response.status.should eq 401
    end
  end

end
