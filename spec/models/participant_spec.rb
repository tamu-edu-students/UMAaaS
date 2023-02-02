require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe "associations" do
    it { should belong_to(:program)}
  end
end
