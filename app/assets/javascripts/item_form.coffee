jQuery ->
  EXT = /(\.|\/)(gif|jpe?g|png)$/i
  $fileInput = $('#images_')

  previewImage = ->
      file = $fileInput[0].files[0] if ($fileInput[0].files && $fileInput[0].files[0])
      return unless file?

      $imagePreview = $('.preview')
      console.log $imagePreview
      return $imagePreview.css('background-image', "").text('this file is not supported') unless file.name.match(EXT)
      return $imagePreview.css('background-image', "").text('image size to large (> 1MB)') if file.size > 1048576

      if (window.File && window.FileReader && window.FileList && window.Blob)
        reader = new FileReader()
        reader.onload = (e) => $imagePreview.css('background-image', "url(#{e.target.result})").text('')
        reader.readAsDataURL(file)
      else
        $imageContainer.css('background-image', "none")
        alert 'Unsupported preview image in this browser. Change it!'

  $fileInput.change(previewImage)
  $('.preview').on 'click', (e) ->
      e.preventDefault()
      $fileInput.trigger('click')
