require 'rails_helper'

RSpec.describe FlagExperience, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:experience) }
  end

  describe "attributes" do
    it { should respond_to(:hasUserFlagged) }
  end

  describe "validations" do
    # Add any relevant validations for the FlagExperience model
  end
end
