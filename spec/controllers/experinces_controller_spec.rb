require 'rails_helper'

RSpec.describe ExperiencesController, type: :controller do


  describe "POST #create" do
    it "with valid params" do
          get :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1 }
          expect(flash[:notice]).to match(/Experience was successfully created./)

      end

    #   it "attaches an image if one is provided" do
    #     image = fixture_file_upload("test.png", "image/png")
    #     post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1, image: image }

    #     expect(Experience.last.image).to be_attached
    #   end

    #   it "creates a new YelpLocation if yelp_id is provided" do
    #     expect {
    #       post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1, yelp_id: "test_yelp_id", yelp_name: "Test Yelp Name", yelp_address: "Test Yelp Address", yelp_alias: "test_yelp_alias", yelp_url: "http://test_yelp_url.com", yelp_image_url: "http://test_yelp_image_url.com", yelp_rating: 5, yelp_tags: "test, yelp, tags" }
    #     }.to change(YelpLocation, :count).by(1)
    #   end

    #   it "redirects to the portal path" do
    #     post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: 5, tags: "test, tags" }, id: 1 }
    #     expect(response).to redirect_to(portal_path(1))
    #   end
    # end

    # context "with invalid params" do
    #   it "does not create a new Experience if experience or rating is blank" do
    #     expect {
    #       post :create, params: { experience: { title: "Test Title", experience: "", rating: 5, tags: "test, tags" }, id: 1 }
    #     }.to change(Experience, :count).by(0)

    #     expect {
    #       post :create, params: { experience: { title: "Test Title", experience: "Test Experience", rating: nil, tags: "test, tags" }, id: 1 }
    #     }.to change(Experience, :count).by(0)
    #   end

  
  end
  end
