
require 'rails_helper'

RSpec.describe FlagTip, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:tip) }
  end

  describe "attributes" do
    it { should respond_to(:hasUserFlagged) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:tip) }
  end
end
