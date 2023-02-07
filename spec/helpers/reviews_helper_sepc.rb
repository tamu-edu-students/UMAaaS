# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReviewsHelper, type: :helper do
  # pending "add some examples to (or delete) #{__FILE__}"

  # need to determine why its not getting businesses from the query

  describe '#search' do
    it 'Checks that a search has a response with businesses' do
      response = helper.search('food', 'colleg station')
      expect(response['total'].to_i).to be > 0
    end
  end

  describe '#search_location' do
    it 'Checks that searching current location has a response with businesses' do
      # uses the lat and long of college station
      response = helper.search_location('food', 30.613971800352598, -96.32022857666016)
      expect(response['total'].to_i).to be > 0
    end
  end

  describe '#business' do
    it 'Checks if looking up a business is successful' do
      id = '_CgYVNP8zavac_XKLpKwoQ'
      name = "Howdy's Texas Grill'd Pizza"
      resposne = helper.business(id)
      expect(response.status).to eq 200
    end
  end

  describe '#get_display_results' do
    it 'Checks that the reviews are correct and builds the objects' do
      response_list = helper.get_display_results(helper.search('food', 'college station'))
      # checks that the first response for food in college station is Mad Taco
      expect(response_list[0]['name']).to eq 'Mad Taco'
    end
  end

  describe '#build_display_result' do
    let(:hash_keys) { %w[id name image type address rating price service safety tags] }
    it 'checks that the result was built properly' do
      # using Howdy's as an example"
      id = '_CgYVNP8zavac_XKLpKwoQ'
      name = "Howdy's Texas Grill'd Pizza"
      result = helper.build_display_result(helper.business(id))
      tags = []
      result.each do |tag|
        tags << tag[0]
      end
      expect(tags).to contain_exactly(*hash_keys)
    end
  end

  describe '#get_average' do
    it 'Checks that the average was calculated correctly' do
      reviews = [{ 'rating' => 5 }, { 'rating' => nil }, { 'rating' => 3 }, { 'rating' => 4 }, { 'rating' => nil },
                 { 'rating' => 1 }, { 'rating' => 5 }, { 'rating' => 3 }]
      result = helper.get_average(reviews, 'rating')
      result_2 = helper.get_average([], 'rating')
      result_3 = helper.get_average(reviews, 'price')
      expect(result).to eq 3.5
      expect(result_2).to eq 0
      expect(result_3).to eq 0
      # TODO
    end
  end

  describe '#get_tags' do
    it 'Returns a list of the valid tags' do
      reviews = [
        { 'cash_only' => true, 'english' => true, 'tips' => false, 'wifi' => true, 'wheelchair' => false },
        { 'cash_only' => false, 'english' => true, 'tips' => false, 'wifi' => true, 'wheelchair' => false },
        { 'cash_only' => false, 'english' => true, 'tips' => false, 'wifi' => true, 'wheelchair' => false },
        { 'cash_only' => false, 'english' => true, 'tips' => true, 'wifi' => true, 'wheelchair' => false },
        { 'cash_only' => false, 'english' => false, 'tips' => true, 'wifi' => true, 'wheelchair' => false },
        { 'cash_only' => false, 'english' => true, 'tips' => false, 'wifi' => true, 'wheelchair' => false },
        { 'cash_only' => false, 'english' => true, 'tips' => true, 'wifi' => true, 'wheelchair' => false }
      ]
      result = helper.get_tags(reviews)
      result_2 = helper.get_tags([])
      expect(result).to eq %w[english wifi]
      expect(result_2).to eq []
      # TODO
    end
  end

  describe '#get_correct_order' do
    it 'Orders the reviews to put student reviews first' do
      reviews = [
        { 'rating' => 4.3 },
        { 'rating' => -1 },
        { 'rating' => 2.7 },
        { 'rating' => 3.5 },
        { 'rating' => -1 },
        { 'rating' => -1 },
        { 'rating' => 4.5 }
      ]
      result = helper.get_correct_order(reviews)
      result_2 = helper.get_correct_order([])
      expect(result).to eq [{ 'rating' => 4.3 }, { 'rating' => 2.7 }, { 'rating' => 3.5 }, { 'rating' => 4.5 },
                            { 'rating' => -1 }, { 'rating' => -1 }, { 'rating' => -1 }]
      expect(result_2).to eq []
    end
  end
end
