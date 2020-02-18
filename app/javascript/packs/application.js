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

  $("#index-search-box select").change(function(){
    var selectedId = $(this).find(":selected").val();
    if(selectedId != 0) $("#index-search-box-form").submit();
  });
  
  $("#portal-switch-programs select").change(function(){
    var selectedId = $(this).find(":selected").val();
    if(selectedId != 0) $("#portal-switch-programs-form").submit();
  });
  
  $(".tip-helpful-yes").click(function(){
    var idParts = this.id.split("-");
    var tipId = idParts[2];
    alert("Upvote "+tipId);
  });
  
  $(".portal-experience-leave-comment textarea").focus(function(){
    $(".portal-experience-leave-comment.active").removeClass("active").addClass("inactive");
    var wrapperId = "wrapper_" + $(this).attr('id');
    $("#"+wrapperId).addClass("active").removeClass("inactive");
  });
  
  $(".portal-experience-leave-comment input[type=submit]").click(function(){
    var experienceId = $(this).attr('id').split('_')[3];
    var commentText = $("#add_comment_"+experienceId).val();
    var radioValue = $("input[name='comment_rating_" + experienceId + "']:checked").val();

    $.ajax({
      type: "POST", 
      url: "/experience/"+experienceId+"/comment",
      data: {experienceId: experienceId, commentText: commentText, rating: radioValue},
      dataType: "json",
      success: function(data, textStatus, jqXHR){
        //alert('great success!');
        //alert(JSON.stringify(data));
      },
      error: function(jqXHR, textStatus, errorThrown){
      }
    });
    
    // reset inputs
    $("#add_comment_"+experienceId).val("");
    $("input[name='comment_rating_" + experienceId + "']:checked").prop('checked', false);

  });
  
  $(".portal-experience-comment-count").click(function(){
    $(this).children(":first").toggleClass("down-arrow up-arrow");
    $(this).siblings(".portal-experience-comments-list").slideToggle("fast");
  });
  
  
  // For the Users page, adds filtering param to the url to only show a selected program
  $("#users-filter-programs").change(function(){
    window.location.replace(generateUserListParams());
  });
  
  $("#users-filter-show-banned").change(function(){
    window.location.replace(generateUserListParams());
  });

  // For the Programs page
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