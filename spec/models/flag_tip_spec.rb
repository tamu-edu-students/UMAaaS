require 'rails_helper'

RSpec.describe FlagTip, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:tip) }
  end
end
