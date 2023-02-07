
require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe "associations" do
    it { should belong_to(:program) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:program) }
    it { should validate_presence_of(:user) }
  end
end

