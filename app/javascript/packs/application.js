// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
/*global $*/

//$(function(){
document.addEventListener("turbolinks:load", function() {  // the site uses turbolinks so have to use this instead of regular jquery opening

/////////////////////////////////
// for all pages
//
  $(".flash-alert-button input").click(function(){
    $(".flash-alert-wrapper").hide();
  });



/////////////////////////////////
// for homepage
//
  $("#index-search-box select").change(function(){
    var selectedId = $(this).find(":selected").val();
    if(selectedId != 0) $("#index-search-box-form").submit();
  });
  
  
  
/////////////////////////////////
// for portal page
//
  $("#portal-switch-programs select").change(function(){
    var selectedId = $(this).find(":selected").val();
    if(selectedId != 0) $("#portal-switch-programs-form").submit();
  });
  
  $(".tip-helpful-yes").click(function(){
    var idParts = this.id.split("-");
    var tipId = idParts[2];
    alert("Upvote "+tipId);
  });
  
  // The .off fixes a problem with the javascript getting double loaded by turbolinks when the back button is used
  // that was causing events to get double triggered. So the .off removes any extra events then adds just a single instance
  
  $(document).off('focus', '.portal-experience-leave-comment textarea').on('focus', '.portal-experience-leave-comment textarea', function(){
    $(".portal-experience-leave-comment.active").removeClass("active").addClass("inactive");
    var wrapperId = "wrapper_" + $(this).attr('id');
    $("#"+wrapperId).addClass("active").removeClass("inactive");
  });
  
  $(document).off('click', '.portal-experience-leave-comment input[type=submit]').on('click', '.portal-experience-leave-comment input[type=submit]', function(){
    var experienceId = $(this).attr('id').split('_')[3];
    var radioValue = $("input[name='comment_rating_" + experienceId + "']:checked").val();
    var commentText = $("#add_comment_"+experienceId).val();
    if(commentText == "") return;
    if(radioValue || confirm("Submit your comment without a rating?")){
      $(".portal-experience-leave-comment.active").removeClass("active").addClass("inactive");
  
      $.ajax({
        type: "POST", 
        url: "/experience/"+experienceId+"/comment",
        data: {experienceId: experienceId, commentText: commentText, rating: radioValue},
        dataType: "script",
        success: function(data, textStatus, jqXHR){
        },
        error: function(jqXHR, textStatus, errorThrown){
        }
      });
      
      // reset inputs
      $("#add_comment_"+experienceId).val("");
      $("input[name='comment_rating_" + experienceId + "']:checked").prop('checked', false);
    }

  });
  
  $(document).off('click', '.portal-experience-comment-count').on('click', '.portal-experience-comment-count', function(){
    $(this).children(":first").toggleClass("down-arrow up-arrow");
    $(this).siblings(".portal-experience-comments-list").slideToggle("fast");
  });
  
  $("#portal-sort-experiences").change(function(){
    window.location.replace(generatePortalParams());
  });
  
  

/////////////////////////////////
// for new experience page
//
  var typingTimer;                //timer identifier
  var doneTypingInterval = 750;  //time in ms (.75 seconds)

  //on keyup, start the countdown
  $(document).off('input', '#yelp-search').on('input', '#yelp-search', function(){
    clearTimeout(typingTimer);
    if ($(this).val()) {
        typingTimer = setTimeout(searchYelp, doneTypingInterval);
        
        $("#yelp-search-results").show();
        if(!$("#yelp-search-results").children("#yelp-searching-indicator").length){
          $("#yelp-search-results").prepend("<div id='yelp-searching-indicator'>searching...</div>");
        }
    }else{
      $("#yelp-search-results").hide();
      $("#yelp-search-results").empty();
    }
  });
  
  //when a yelp search result is clicked
  $(document).off('click', '.yelp-search-result').on('click', '.yelp-search-result', function(){
    // clear the search bar and results and hide them
    $("#yelp-search-wrapper").hide();
    $("#yelp-search-results").empty();
    $("#yelp-search-results").hide();
    $("#yelp-search").val("");
    
    // then add the business details to the selected location display and show it
    $("#yelp-location-wrapper").append("<div id='yelp-selected-location'><div id='yelp-remove-selected-location'>&#10006;</div>" + $(this).children(".yelp-search-result-name").text() + "</div>");
    $("#yelp-location-wrapper").show();
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_name' class='yelp-hidden-field' value=\"" + $(this).children(".yelp-search-result-name").text() + "\">");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_address' class='yelp-hidden-field' value=\"" + $(this).children(".yelp-search-result-address").text() + "\">");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_alias' class='yelp-hidden-field' value='" + $(this).children(".yelp-search-result-alias").text() + "'>");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_id' class='yelp-hidden-field' value='" + $(this).children(".yelp-search-result-id").text() + "'>");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_url' class='yelp-hidden-field' value='" + $(this).children(".yelp-search-result-url").text() + "'>");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_image_url' class='yelp-hidden-field' value='" + $(this).children(".yelp-search-result-image-url").text() + "'>");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_rating' class='yelp-hidden-field' value='" + $(this).children(".yelp-search-result-rating").text() + "'>");
    $("#yelp-location-wrapper").append("<input type='text' name='yelp_tags' class='yelp-hidden-field' value=\"" + $(this).children(".yelp-search-result-tags").text() + "\">");
  });
  
  //when a selected location's X is clicked to remove it
  $(document).off('click', '#yelp-remove-selected-location').on('click', '#yelp-remove-selected-location', function(){
    $("#yelp-location-wrapper").hide();
    $("#yelp-location-wrapper").empty();
    $("#yelp-search-wrapper").show();
  });


/////////////////////////////////
// for users page
//
  // adds filtering param to the url to only show a selected program
  $("#users-filter-programs").change(function(){
    window.location.replace(generateUserListParams());
  });
  
  $("#users-filter-show-banned").change(function(){
    window.location.replace(generateUserListParams());
  });



/////////////////////////////////
// for programs page
//
  $("#programs-filter-show-disabled").change(function(){
    window.location.replace(generateProgramListParams());
  });
  
});

function generateUserListParams(){
  var params = "?";
  var selectedId = $("#users-filter-programs").find(":selected").val();
  if(selectedId != 0){
    params += "p="+selectedId;
  }
  if ($('#users-filter-show-banned').is(":checked")){
    if(params.length > 1) params += "&";
    params += "b=true";
  }
  return params;
}

function generateProgramListParams(){
  var params = "?";
  if ($('#programs-filter-show-disabled').is(":checked")){
    if(params.length > 1) params += "&";
    params += "d=true";
  }
  return params;
}

function generatePortalParams(){
  var params = "?";
  var selectedId = $("#portal-sort-experiences").find(":selected").val();
  if(selectedId != "rating"){  // date is default so it doesn't need to be in the URL parameters
    params += "sort_exp="+selectedId;
  }

  return params;
}


//user is "finished typing," search Yelp
function searchYelp () {
  $.ajax({
    type: "POST", 
    url: "/experience/yelp_search",
    data: {yelpTerm: $("#yelp-search").val(), yelpLocation: $("#yelp-near").val()},
    dataType: "json",
    success: function(data, textStatus, jqXHR){
      
      $("#yelp-search-results").empty();
      for(let result = 0; result < data.businesses.length; result++){
        var resultHTML = "<div class='yelp-search-result' id='yelp-result-" + result + "'>";
        resultHTML += "<div class='yelp-search-result-name'>"+ data.businesses[result].name  +"</div>";
        
        var addressHTML = "";
        for(let i = 0; i < data.businesses[result].location.display_address.length; i++){
          addressHTML += data.businesses[result].location.display_address[i] + " ";
        }
        
        var categoriesHTML = "";
        for(let i = 0; i < data.businesses[result].categories.length; i++){
          if(categoriesHTML != "") categoriesHTML += ", ";
          categoriesHTML += data.businesses[result].categories[i].title;
        }
        
        resultHTML += "<div class='yelp-search-result-address'>"+ addressHTML + "</div>";
        resultHTML += "<div class='yelp-search-result-id yelp-hidden-field'>"+ data.businesses[result].id  +"</div>";
        resultHTML += "<div class='yelp-search-result-alias yelp-hidden-field'>"+ data.businesses[result].alias  +"</div>";
        resultHTML += "<div class='yelp-search-result-image-url yelp-hidden-field'>"+ data.businesses[result].image_url  +"</div>";
        resultHTML += "<div class='yelp-search-result-url yelp-hidden-field'>"+ data.businesses[result].url  +"</div>";
        resultHTML += "<div class='yelp-search-result-rating yelp-hidden-field'>"+ data.businesses[result].rating  +"</div>";
        resultHTML += "<div class='yelp-search-result-tags yelp-hidden-field'>"+ categoriesHTML  +"</div>";
        resultHTML += "</div>";
  
        $("#yelp-search-results").append(resultHTML);
      }
      if(data.businesses.length == 0){
        $("#yelp-search-results").append("<div class='yelp-search-empty'>No results found</div>");
      }
      
      $("#yelp-search-results").slideDown("fast");
      
    },
    error: function(jqXHR, textStatus, errorThrown){
    }
  });
}