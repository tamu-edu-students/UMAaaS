# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe ProgramsController, type: :controller do
#   let(:program) { create(:program) }

#   describe "GET #index" do
#     it "returns a success response" do
#       get :index
#       expect(response).to be_successful
#     end
#   end

#   describe "GET #new" do
#     it "returns a success response" do
#       get :new
#       expect(response).to be_successful
#     end
#   end

#   describe "POST #create" do
#     context "with valid params" do
#       let(:valid_attributes) { { name: "Program 1", location: "Location 1", region: "Region 1" } }

#       it "creates a new Program" do
#         expect { post :create, params: { program: valid_attributes } }.to change(Program, :count).by(1)
#       end

#       it "redirects to the created program" do
#         post :create, params: { program: valid_attributes }
#         expect(response).to redirect_to(programs_path)
#       end
#     end

#     context "with invalid params" do
#       let(:invalid_attributes) { { name: "", location: "", region: "" } }

#       it "does not create a new Program" do
#         expect { post :create, params: { program: invalid_attributes } }.to change(Program, :count).by(0)
#       end

#       it "redirects to programs path" do
#         post :create, params: { program: invalid_attributes }
#         expect(response).to redirect_to(programs_path)
#       end
#     end
#   end

#   describe "PUT #update" do
#     context "with valid params" do
#       let(:new_attributes) { { name: "Program 2", location: "Location 2", region: "Region 2" } }

#       it "updates the requested program" do
#         put :update, params: { id: program.to_param, program: new_attributes }
#         program.reload
#         expect(program.name).to eq("Program 2")
#         expect(program.location).to eq("Location 2")
#         expect(program.region).to eq("Region 2")
#       end

#       it "redirects to the program" do
#         put :update, params: { id: program.to_param, program: new_attributes }
#         expect(response).to redirect_to(programs_path)
#       end
#     end

#     context "with invalid params" do
#       let(:invalid_attributes) { { name: "", location: "", region: "" } }

#       it "does not update the requested program" do
#         put :update, params: { id: program.to_param, program: invalid_attributes }
#         program.reload
#         expect(program.name).not_to eq("")
#         expect(program.location).not_to eq("")
#         expect(program.region).not_to eq("")
#       end
#   end
#   end
#   end
