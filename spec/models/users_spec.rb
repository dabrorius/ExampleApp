require 'spec_helper'

describe User do
 
  describe "#access_token" do

    it "is set when user is created" do
      user = FactoryGirl.create(:user, access_token: nil)
      user.access_token.should_not be_nil
    end

    it "is not change when user is updated" do
      user = FactoryGirl.create(:user)
      expect { user.update_attributes email: 'new_email@mail.com' }.
      to_not change{ user.reload.access_token }
    end
  end

end