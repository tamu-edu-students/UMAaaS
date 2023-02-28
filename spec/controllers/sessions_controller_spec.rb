
require 'rails_helper'
require 'factory_bot'


RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with a tamu email' do
      before do
        user_info = { 'uid' => '12345', 'info' => { 'name' => 'Test User', 'email' => 'testuser@tamu.edu', 'image' => 'imageurl' } }
        request.env['omniauth.auth'] = user_info
        post :create, params: { hd: 'tamu.edu' }
      end

      it 'creates a new user if one does not exist' do
        expect(User.count).to eq(1)
      end

      it 'sets the user in the session' do
        expect(session[:user]).to eq(User.first.id)
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with an admin email' do
      before do
        Rails.configuration.admin_email = 'admin@tamu.edu'
        user_info = { 'uid' => '12345', 'info' => { 'name' => 'Test User', 'email' => 'admin@tamu.edu', 'image' => 'http://test_image.com' } }
        request.env['omniauth.auth'] = user_info
      end
      
      it 'sets the user as admin' do
        post :create
        expect(User.find_by(email: 'admin@tamu.edu').admin).to be true
      end

      it 'sets the user_admin in session to true' do
        post :create
        expect(session[:user_admin]).to be true
      end

      it 'redirects to the root path' do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with a non-admin email' do
      before do
        Rails.configuration.admin_email = 'admin@tamu.edu'
        user_info = { 'uid' => '12345', 'info' => { 'name' => 'Test User', 'email' => 'test@tamu.edu', 'image' => 'http://test_image.com' } }
        request.env['omniauth.auth'] = user_info
      end

      it 'does not set the user as admin' do
        post :create
        expect(User.find_by(email: 'test@tamu.edu').admin).to be false
      end

      it 'sets the user_admin in session to false' do
        post :create
        expect(session[:user_admin]).to be false
      end

      it 'redirects to the root path' do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user is not found in the database' do
      before do
        let(:user_info) { { 'uid' => '12345', 'info' => { 'email' => 'test@tamu.edu', 'name' => 'Test User', 'image' => 'image_url' } } }
      end
        
      it 'creates a new user in the database' do
        expect { get :create, params: { hd: 'tamu.edu' } }.to change { User.count }.by(1)

        new_user = User.last
        expect(new_user.uid).to eq '123456'
        expect(new_user.name).to eq 'Test User'
        expect(new_user.email).to eq 'testuser@tamu.edu'
        expect(new_user.banned).to be false
        expect(new_user.admin).to be false
      end

      it 'sets the user information in the session' do
        get :create, params: { hd: 'tamu.edu' }

        new_user = User.last
        expect(session[:user]).to eq new_user.id
        expect(session[:user_admin]).to be false
        expect(session[:user_img]).to eq 'http://example.com/image.jpg'
        expect(session[:user_program_id]).to be nil
        expect(session[:user_email]).to eq 'testuser@tamu.edu'
      end

      it 'redirects to the root path' do
        get :create, params: { hd: 'tamu.edu' }

        expect(response).to redirect_to root_path
      end
    end
  end
#   
describe "DELETE #destroy" do
    let(:user) { create(:user) }

    before do
      session[:user] = user.id
      session[:user_admin] = true
      session[:user_img] = 'http://example.com/user.png'
      session[:user_program_id] = 123
      session[:user_email] = 'user@example.com'
    end

    it "clears the session keys and redirects to the root path" do
      delete :destroy
      expect(session[:user]).to be_nil
      expect(session[:user_admin]).to be_nil
      expect(session[:user_img]).to be_nil
      expect(session[:user_program_id]).to be_nil
      expect(session[:user_email]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

end