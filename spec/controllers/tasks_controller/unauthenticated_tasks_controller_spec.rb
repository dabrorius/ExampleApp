require 'spec_helper'

describe TasksController do

  describe "#index" do
    it "redirects to sign in page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "#create" do
    it "redirects to sign in page" do
      post :create
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "#update" do
    it "redirects to sign in page" do
      patch :update, id: 1
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "#destroy" do
    it "redirects to sign in page" do
      delete :destroy, id: 1
      response.should redirect_to(new_user_session_path)
    end
  end

end
