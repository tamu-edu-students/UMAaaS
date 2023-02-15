# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TipsController, type: :controller do
  let(:tip) { create(:tip, program_id: 2) }

  describe "POST #create" do
    it "creates with valid params" do
      get :create, params: { tip: { tip: "Test Title",}, id: 1 }
      expect(flash[:notice]).to match(/Tip was successfully created./)
    end

    it "creates with invalid params" do
      get :create, params: { tip: { tip: "",}, id: 1 }
      expect(flash[:notice]).to match(/Cannot create tip/)
    end
  end
end
