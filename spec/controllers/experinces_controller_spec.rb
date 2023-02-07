# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExperiencesController, type: :controller do

  
  let(:experience) { create(:experience, program_id: 2) }


  describe "POST #create" do
    it "creates with valid params" do
          get :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1 }
          expect(flash[:notice]).to match(/Experience was successfully created./)

    end

      # it "attaches an image if one is provided" do
      #   image = fixture_file_upload("./test.png", "image/png")
      #   post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1, image: image }

      #   expect(Experience.last.image).to be_attached
      # end

    #   it "creates a new YelpLocation if yelp_id is provided" do
    #     expect {
    #       post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1, yelp_id: "test_yelp_id", yelp_name: "Test Yelp Name", yelp_address: "Test Yelp Address", yelp_alias: "test_yelp_alias", yelp_url: "http://test_yelp_url.com", yelp_image_url: "http://test_yelp_image_url.com", yelp_rating: 5, yelp_tags: "test, yelp, tags" }
    #     }.to change(YelpLocation, :count).by(1)
    #   end

      it "redirects to the portal path" do
        post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1 }
        expect(response).to redirect_to(portal_path(1))
      end
      
        it "creates withou valid params" do
          get :create, params: { experience: { title: "Test Title", experience: "Test Experience", tags: "test, tags" }, id: 1 }
          expect(flash[:alert]).to match(/Cannot create experience/)

    end
    
  end
  
  
  
   describe 'GET #view' do
     
      it 'redirects to portal path with an alert' do
        get :view, params: { id: 12 }
        expect(flash[:alert]).to eq('You are not assigned to this program.')
        expect(response).to redirect_to(portal_path(experience.id))
     end
     
   end
  
  
  
  
  
  
  end

