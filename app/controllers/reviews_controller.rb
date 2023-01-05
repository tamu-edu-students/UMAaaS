require 'reviews_helper'
include ReviewsHelper
require 'json'

class ReviewsController < ApplicationController
	protect_from_forgery with: :null_session

	def index

	end


	def leave_review
		@review = Review.new
	end


	def show

	end

	def emergency
	end

	def review_params

	end

	def create

	end

	def yelp_help(food, city)
		# search(food, city)
	end

	def yelp_help_location(food, lat, long)
		# search_location(food, lat, long)
	end

end
