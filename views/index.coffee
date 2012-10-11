jQuery ->
  imgsize = '15'
  clipimg = "<img src=\"glyphicons_029_notes_2-resize.png\" height=\"#{imgsize}\" width=\"#{imgsize}\">"
  okimg = "<img src=\"glyphicons_198_ok-resize-invert.png\" height=\"#{imgsize}\" width=\"#{imgsize}\">"
  copy_button_click = (clip, text) ->
    $('#' + clip.domElement.id).html(okimg)
    $('#' + clip.domElement.id).addClass('btn-success')
    setTimeout(copy_button_unclick, 1500)
  copy_button_unclick = ->
    $('.clip_button').html(clipimg)
    $('.clip_button').removeClass('btn-success')
    
  passphrases = ->
    console.log $('#options_form').serialize()
    formdata = $('#options_form').serialize()
    $.getJSON('passphrases', formdata, (data) ->
      rows = []
      clips = []
      for phrase, index in data
        clip = new ZeroClipboard.Client()
        clip.setText(phrase)
        button = '<div id="d_clip_container_' + index + '" style="position:relative">
           <button id="d_clip_button_' + index + '" class="clip_button btn btn-small">' + clipimg + '</button>
        </div>'
        clips.push([clip, 'd_clip_button_' + index, 'd_clip_container_' + index])
        rows.push('<tr><td><div class="passphrase">' + phrase + '</div></td><td class="td_button">' + button + '</td></tr>')
      $('table#passphrases > tbody').html(rows.join(''))
      for clip in clips
        clip[0].glue(clip[1], clip[2])
        clip[0].addEventListener('onComplete', copy_button_click)
    )
  
  passphrases()
  
  $('#options_form').change(passphrases)
  $('#generate_btn').click(passphrases)
  $('#options_btn').click ->
    $('#options').slideToggle()
