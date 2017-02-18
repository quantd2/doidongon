$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  var dropzone = new Dropzone (".dropzone", {
    maxFilesize: 256, // Set the maximum file size to 256 MB
    paramName: "item_image[image]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: false // Don't show remove links on dropzone itself.
  });

  dropzone.on("success", function(file) {
    this.removeFile(file)
    $.getScript("/images")
  })
});
