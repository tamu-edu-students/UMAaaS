const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$(document).on("turbolinks:load", function() {
    console.log('here')
    // Function to handle when submitting review, checking for empty input
    $("#new_review").submit(() => {
        //if not logged in
        if ($("#review_user_email").val() === "not logged in") {
            alert("Please log in before leaving a review")
            return false;
        }
        if ($("#review_anonymous_yes:checked").length === 1) {
            $("#review_name").val("Anonymous");
        }
        /*
        // If comment section is empty
        if ($("#review_comment").val() === "") {
            alert("Please leave a comment");
            return false;
        }
        // If no button selected for rating
        if ($("#review_rating_block").children("input:checked").length === 0) {
            alert("Please leave an overall rating");
            return false;
        }
        // If no button selected for price
        if ($("#review_price_block").children("input:checked").length === 0) {
            alert("Please leave a price rating");
            return false;
        }
        // If no button selected for safety
        if ($("#review_safety_block").children("input:checked").length === 0) {
            alert("Please leave a safety rating");
            return false;
        }
        // If no button selected for service
        if ($("#review_service_block").children("input:checked").length === 0) {
            alert("Please leave a service rating");
            return false;
        }
        // If no button selected for cash only
        if ($("#review_cash_only_block").children("input:checked").length === 0) {
            alert("Please specify whether this place accepts cash");
            return false;
        }
        // If no button selected for english
        if ($("#review_english_block").children("input:checked").length === 0) {
            alert("Please specify whether the employees here speak English");
            return false;
        }
        // If no button selected for tips
        if ($("#review_tips_block").children("input:checked").length === 0) {
            alert("Please specify whether it is customary to leave tips");
            return false;
        }
        // If no button selected for wifi
        if ($("#review_wifi_block").children("input:checked").length === 0) {
            alert("Please specify whether this place has free WiFi");
            return false;
        }
        // If no button selected for wheelchair
        if ($("#review_wheelchair_block").children("input:checked").length === 0) {
            alert("Please specify whether this place is wheelchair accessible");
            return false;
        }
        */
        return true
    });
});