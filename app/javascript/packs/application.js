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

$(function(){

  $("#index-search-box select").change(function(){
    var selectedId = $(this).find(":selected").val();
    if(selectedId != 0) $("#index-search-box-form").submit();
  });
  
  $("#portal-switch-programs select").change(function(){
    var selectedId = $(this).find(":selected").val();
    if(selectedId != 0) $("#portal-switch-programs-form").submit();
  });
  
  
  // For the Users page, adds filtering param to the url to only show a selected program
  $("#users-filter-programs").change(function(){
    window.location.replace(generateUserListParams());
  });
  
  $("#users-filter-show-banned").change(function(){
    window.location.replace(generateUserListParams());
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