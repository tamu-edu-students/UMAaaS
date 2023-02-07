# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    describe ApplicationController do
      controller(ApplicationController) do
        def index
          render plain: "Hello"
        end
      end
    
      describe "#logged_in?" do
        context "when in test environment" do
          it "returns true" do
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("test"))
            controller.instance_variable_set(:@_current_user, User.new)
            expect(controller.logged_in?).to be true
          end
        end
    
        context "when not in test environment" do
          it "returns true when current user id is positive" do
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("not_test"))
            current_user = User.new
            current_user.id = 1
            controller.instance_variable_set(:@_current_user, current_user)
            expect(controller.logged_in?).to be true
          end
    
          it "returns false when current user id is not positive" do
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("not_test"))
            current_user = User.new
            current_user.id = 0
            controller.instance_variable_set(:@_current_user, current_user)
            expect(controller.logged_in?).to be false
          end
        end
      end
    
      describe "#current_user" do
        context "when in test environment" do
          it "returns a new user object with specific values" do
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("test"))
            current_user = controller.current_user
            expect(current_user.id).to eq("4")
            expect(current_user.admin).to be false
            expect(current_user.img).to be nil
            expect(current_user.user_program_id).to be nil
          end
        end
    
        context "when not in test environment" do
          it "returns a new user object with values from session" do
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("not_test"))
            session[:user_admin] = true
            session[:user_email] = "example@example.com"
            session[:user_img] = "example.jpg"
            session[:user] = 1
            session[:user_program_id] = 2
            current_user = controller.current_user
            expect(current_user.admin).to be true
            expect(current_user.email).to eq("example@example.com")
            expect(current_user.img).to eq("example.jpg")
            expect(current_user.id).to eq(1)
            expect(current_user.user_program_id).to eq(2)
          end
        end
      end
    end
    
    
    Regenerate response
end
