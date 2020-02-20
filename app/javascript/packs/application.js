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
  
  $(document).on('focus', '.portal-experience-leave-comment textarea', function(){
    $(".portal-experience-leave-comment.active").removeClass("active").addClass("inactive");
    var wrapperId = "wrapper_" + $(this).attr('id');
    $("#"+wrapperId).addClass("active").removeClass("inactive");
  });
  
  $(document).on('click', '.portal-experience-leave-comment input[type=submit]', function(){
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
  
  $(document).on('click', '.portal-experience-comment-count', function(){
    $(this).children(":first").toggleClass("down-arrow up-arrow");
    $(this).siblings(".portal-experience-comments-list").slideToggle("fast");
  });
  
  $("#portal-sort-experiences").change(function(){
    window.location.replace(generatePortalParams());
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