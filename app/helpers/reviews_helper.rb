##########################################################################################
## This file is from https://github.com/Yelp/yelp-fusion/blob/master/fusion/ruby/sample.rb
##########################################################################################
require "json"
require "http"
require "optparse"
require "set"
module ReviewsHelper
    # Place holders for Yelp Fusion's API key. Grab it
    # from https://www.yelp.com/developers/v3/manage_app
    API_KEY = "nAdNfTSPlY4wsOCafXhDIBdhK4zTbJ4F3LLsTpPsyeI85der6bOUWATcVPjlTvsKRFKypjk2Yk4HLEYqlCcTqcby1ShlBWxXzD3q_z32fvHTO8Wk-XaBUxeUsmYRXnYx"


    # Constants, do not change these
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path


    DEFAULT_BUSINESS_ID = "yelp-san-francisco"
    DEFAULT_TERM = "dinner"
    DEFAULT_LOCATION = "San Francisco, CA"
    SEARCH_LIMIT = 5


    # Make a request to the Fusion search endpoint. Full documentation is online at:
    # https://www.yelp.com/developers/documentation/v3/business_search
    #
    # term - search term used to find businesses
    # location - what geographic location the search should happen
    #
    # Examples
    #
    #   search("burrito", "san francisco")
    #   # => {
    #          "total": 1000000,
    #          "businesses": [
    #            "name": "El Farolito"
    #            ...
    #          ]
    #        }
    #
    #   search("sea food", "Seattle")
    #   # => {
    #          "total": 1432,
    #          "businesses": [
    #            "name": "Taylor Shellfish Farms"
    #            ...
    #          ]
    #        }
    #
    # Returns a parsed json object of the request
    def search(term, location)
        url = "#{API_HOST}#{SEARCH_PATH}"
        params = {
            term: term,
            location: location,
            limit: 50,
        }
        response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        response.parse
    end

    def search_location(term, latitude, longitude)
        url = "#{API_HOST}#{SEARCH_PATH}"
        params = {
            term: term,
            latitude: latitude,
            longitude: longitude,
            limit: 50,
        }
        response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        response.parse
    end


    # Look up a business by a given business id. Full documentation is online at:
    # https://www.yelp.com/developers/documentation/v3/business
    # 
    # business_id - a string business id
    #
    # Examples
    # 
    #   business("yelp-san-francisco")
    #   # => {
    #          "name": "Yelp",
    #          "id": "yelp-san-francisco"
    #          ...
    #        }
    #
    # Returns a parsed json object of the request
    def business(business_id)
        url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
        response = HTTP.auth("Bearer #{API_KEY}").get(url)
        return response.parse
    end

    def get_display_results(yelp_result)
        display_results = []
        if (!yelp_result.is_a?(Hash))
            return display_results
        end
        if (!yelp_result.key?("businesses"))
            return display_results
        end
        yelp_result["businesses"].each do |biz|
            display_results.push(build_display_result(biz))
        end
        return display_results
    end

    def build_display_result(business)
        result = Hash.new
        result["id"] = business["id"]
        result["name"] = business["name"]
        result["image"] = business["image_url"]
        if (business["categories"].length > 0)
            result["type"] = business["categories"][0]["title"]
        else
            result["type"] = "No Business Type"
        end
        result["address"] = business["location"]["address1"]

        student_reviews = Review.where(business_id: business["id"])
        if (student_reviews.length == 0)
            result["price"] = -1
            result["rating"] = -1
            result["service"] = -1
            result["safety"] = -1
            result["tags"] = []
        else 
            
            result["price"] = get_average(student_reviews, "price")
            result["rating"] = get_average(student_reviews, "rating")
            result["service"] = get_average(student_reviews, "service")
            result["safety"] = get_average(student_reviews, "safety")
            result["tags"] = get_tags(student_reviews)
        end
        return result
    end

    def get_average(reviews, key)
        if reviews.select{|review| review[key].nil?}.length == reviews.length
            return -1
        end
        count = 0
        total = 0
        reviews.each do |review| 
            if (review[key].is_a?(Numeric))
                total = total + review[key]
                count = count + 1
            end
        end
        if (count == 0)
            return 0
        end
        return (total.to_f / count.to_f)
    end

    # If "true" for a tag occurs more often than "false", that tag is included
    def get_tags(reviews)
        tags = ["cash_only", "english", "tips", "wifi", "wheelchair"]
        ret_tags = []
        tags.each do |tag|
            if reviews.select{|review| review[tag] == true}.length > reviews.select{|review| review[tag] == false}.length
                ret_tags.push(tag)
            end
        end
        return ret_tags
    end

    def get_correct_order(old_results)
        new_results = old_results.select {|result| result["rating"] != -1}
        other_results = old_results.select {|result| result["rating"] == -1}
        return new_results + other_results
    end

    def get_best_reviewed_first(old_results)
        new_results = old_results.sort_by {|result| -result['rating']}
    end

    def get_low_price_first(old_results)
        new_results = old_results.select {|result| result['price'] != -1}
        other_results = old_results.select {|result| result['price'] == -1}
        new_results = new_results.sort_by {|result| result['price']}
        new_results += other_results
    end

    def get_high_price_first(old_results)
        new_results = old_results.select {|result| result['price'] != -1}
        other_results = old_results.select {|result| result['price'] == -1}
        new_results = new_results.sort_by {|result| -result['price']}
        new_results += other_results
    end

    def get_tags_first(old_results, tags)
        new_results = old_results.select {|result| (tags - result['tags']).empty?}
        other_results = old_results.select {|result| !(tags - result['tags']).empty?}

        return new_results += other_results
    end

    def get_tags_from_params()
        tags = []

        if !params['cash_only'].blank?
            tags.push('cash_only')
        end
        if !params['english'].blank?
            tags.push('english')
        end
        if !params['tips'].blank?
            tags.push('tips')
        end
        if !params['wifi'].blank?
            tags.push('wifi')
        end
        if !params['wheelchair'].blank?
            tags.push('wheelchair')
        end
        return tags
    end
end
