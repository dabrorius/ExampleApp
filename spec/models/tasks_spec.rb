require 'spec_helper'

describe Task do

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:description) }

  describe "#priority" do
    it "allows nil" do
      should allow_value(nil).for(:priority)
    end

    it "allows values between 0 and 100" do
      should allow_value(0,50,100).for(:priority)
    end

    it "does not allow values less then 0" do
      should_not allow_value(-1).for(:priority)
    end

    it "does not allow values greater then 100" do
      should_not allow_value(101).for(:priority)
    end

    it "does not allow decimal numbers" do
      should_not allow_value(12.74).for(:priority)
    end

    it "does not allow non-numbers" do
      should_not allow_value("string").for(:priority)
    end
  end

  it "can be created" do
    task = FactoryGirl.create(:task)
    task.should be_valid
  end

end