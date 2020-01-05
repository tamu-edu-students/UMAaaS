require 'reviews_helper'
include ReviewsHelper
require 'json'

class ReviewsController < ApplicationController
	protect_from_forgery with: :null_session

	def index
		# Make sure both parameters are present
		if !params[:near].blank? and !params[:find].blank?
			@near = params[:near]
			@find = params[:find]
			if @near === "Current Location"
				@latitude = params[:lat]
				@longitude = params[:long]
				@results = yelp_help_location(@find, @latitude, @longitude)
			else
				# Query yelp to get @find related businesses @near a location
				@results = yelp_help(@find, @near)
				#To see typing of @results, see https://www.yelp.com/developers/documentation/v3/business_search
			end

			@display_results = get_display_results(@results)
			if @display_results.blank?
				flash[:notice] = "No Results Found, Try Modifying Your Search"
				return
			end
			flash[:notice] = nil
			if !params['best_reviews'].blank?
				if params['best_reviews'] == 'true'
					@display_results = get_best_reviewed_first(@display_results)
				end
			end

			if !params['price'].blank?
				if params['price'] == 'high'
					@display_results = get_high_price_first(@display_results)
				end
				if params['price'] == 'low'
					@display_results = get_low_price_first(@display_results)
				end
			end

			tags = get_tags_from_params()

			if !tags.empty?
				@display_results = get_tags_first(@display_results,tags)
			end
			

			@display_results = get_correct_order(@display_results)
		else
			@display_results = []
		end
	end


	def leave_review
		@review = Review.new
	end


	def show
		@yelp_review_id = params[:id]
		#To see typing of @yelp_review_info, see https://www.yelp.com/developers/documentation/v3/business
		@yelp_review_info = business(@yelp_review_id)
		#@user_reviews is an array of type Review. See the types in reviews/db/schema.rb
		@user_reviews = Review.where(business_id: params[:id])

		# Average user price
		@avg_user_price = get_average(@user_reviews, "price")
		# Average user rating
		@avg_user_rating = get_average(@user_reviews, "rating")
		# Average user safety
		@avg_user_safety = get_average(@user_reviews, "safety")
		# Average user service
		@avg_user_service = get_average(@user_reviews, "service")


		# Majority tag values
		@user_tags = get_tags(@user_reviews)

		# Name of Business
		begin
			@name = @yelp_review_info["name"]
		rescue => exception
			@name = "No Name Found"
		end

		# Address call
		begin
			@display_address = [@yelp_review_info["location"]["address1"],
				@yelp_review_info["location"]["city"],
				@yelp_review_info["location"]["state"],
				@yelp_review_info["location"]["zip_code"],
			].join(", ")
			
		rescue => exception
			@display_address = "No Address Found"
		end
		# Alias capitalization
		begin
			@show_alias = @yelp_review_info["categories"][0]["alias"]
			@show_alias[0] = @show_alias[0].capitalize()
		rescue => exception
			@show_alias = "No Alias Found"
		end

		# Display Phone
		begin
			@display_phone = @yelp_review_info["display_phone"] 
		rescue => exception
			@display_phone = "No Phone Number Found"
		end

		# Is business Open
		begin
			@is_open = @yelp_review_info["hours"][0]["is_open_now"] ? "Open Now" : "Closed Now"
		rescue => exception
			@is_open = "Unknown If Currently Open"
		end

		# Get open hours for each day of the week
		begin
			hours = @yelp_review_info["hours"][0]["open"]
		rescue => exception
			hours = []
		end

		days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
		@hours = {
			"Monday" => "Closed",
			"Tuesday" => "Closed",
			"Wednesday" => "Closed",
			"Thursday" => "Closed",
			"Friday" => "Closed",
			"Saturday" => "Closed",
			"Sunday" => "Closed"
		}
		if (hours.length == 0)
			@hours.keys.each{|day| @hours[day] = "No Hours Found"}
		else
			hours.each do |times|
				start = times["start"]
				start_string = ""
				end_ = times["end"]
				end_string = ""

				# Format start time
				if (start.to_i > 1200)
					# After noon
					start_string = (start.to_i - 1200).to_s + " pm"
				else
					# Before noon
					start_string = (start.to_i).to_s + " am"
				end
				start_string = start_string.insert(1, ":")
				# Format end time
				if (end_.to_i > 1200)
					# After noon
					end_string = (end_.to_i - 1200).to_s + " pm"
				else
					# Before noon
					end_string = (end_.to_i).to_s + " am"
				end
				end_string = end_string.insert(1, ":")

				# Format display string
				string_time = ""
				if (start == end_)
					string_time = "Open 24 Hours"
				elsif (end_.to_i < start.to_i)
					string_time = "Open 24 Hours to " + end_string
				else
					string_time = start_string + " - " + end_string
				end

				# Put display string in @hours for a specific day
				@hours[days[times["day"]]] = string_time
			end
		end
	end

	def emergency
	end

	def review_params
		allow = [:business_id, :user_email, :comment, :rating, :price, :safety, :service, :cash_only, :english, :tips, :wifi, :wheelchair, :name]
		params.require(:review).permit(allow)
	end

	def create
		@review = Review.new(review_params)
		respond_to do |format|
			if @review.save
				flash[:notice] = 'Review was successfully created'
				format.html { redirect_to :action => "show", :id => @review["business_id"] }
			else
				formatl.html {render :action => "index"}
			end
		end
	end

	def yelp_help(food, city)
		search(food, city)
	end

	def yelp_help_location(food, lat, long)
		search_location(food, lat, long)
	end

end
