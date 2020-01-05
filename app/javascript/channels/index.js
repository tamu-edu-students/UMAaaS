// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$(document).on("turbolinks:load", function() {
    // Function to handle when searching, handle cases for Current Location/Specific Location
    $("#search_form").submit(() => {
        const find = $("#sb_find").val();
        const near = $("#sb_near").val();
        let search = "?near=" + near;
        search += "&find=" + find;
        if (near === "Current Location") {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    search += "&lat=" + latitude;
                    search += "&long=" + longitude;
                    window.location.search = search; 
                });
                return false;
            }
            else {
                alert("Please Enable Current Loaction");
                return false
            }
        }
        window.location.search = search
        return false;
    });

    // If there are cards, scroll to them
    if ($("#cards").length === 1) {
        $([document.documentElement, document.body]).animate({
            scrollTop: $("#sort_by").offset().top 
        }, 1000);
    }

    $(".our-card").mouseenter(function() {
        $(this).css("box-shadow", "5px 5px 20px #888888");
    });

    $(".our-card").mouseleave(function() {
        $(this).css("box-shadow", "5px 5px 10px #888888");
    });

    $("#price_low").on("click", function() {
        $("#price_high").prop("checked", false);
    });

    $("#price_high").on("click", function() {
        $("#price_low").prop("checked", false);
    })

    $("#submit_sort").on("click", function() {
        let sort_by_params = "";
        const find = $("#sb_find").val();
        const near = $("#sb_near").val();
        sort_by_params = "?near=" + near;
        sort_by_params += "&find=" + find;
        let latitude;
        let longitude;
        if (near === "Current Location") {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    latitude = position.coords.latitude;
                    longitude = position.coords.longitude;
                    sort_by_params += "&lat=" + latitude;
                    sort_by_params += "&long=" + longitude;
                    get_sorting_params(sort_by_params);
                });
            }
        } else {
            get_sorting_params(sort_by_params);
        }
    });

    function get_sorting_params(sort_by_params) {
        let count = 0;
        $("#sort_by").find("input:checked").each(function(index, element) {
            if ($(element).attr("id") == "best_reviewed") {
                sort_by_params += "&best_reviews=true";
            }
            if ($(element).attr("id") == "price_low") {
                sort_by_params += "&price=low";
            }
            else if ($(element).attr("id") == "price_high") {
                sort_by_params += "&price=high";
            }
            if ($(element).attr("id") == "wifi") {
                sort_by_params += "&wifi=true";
            }
            if ($(element).attr("id") == "english") {
                sort_by_params += "&english=true";
            }
            if ($(element).attr("id") == "wheelchair") {
                sort_by_params += "&wheelchair=true";
            }
            count++;
        });
        window.location.search = sort_by_params;
    }
});