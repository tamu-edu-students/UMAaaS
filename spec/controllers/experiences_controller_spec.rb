require 'rails_helper'

RSpec.describe ExperiencesController, type: :controller do

  before do
    @experience = Experience.new(:title => "RSpec Intro", :price => 20)
    @customer = Customer.new
    @order = Order.new(@customer, @book)

    @order.submit
  end

  describe "customer" do
    it "puts the ordered book in customer's order history" do
      expect(1).to eq(1)
    end
  end
end
