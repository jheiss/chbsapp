jQuery ->
  timer = null
  imgsize = '15'
  clipimg = "<img src=\"glyphicons_029_notes_2-resize.png\" height=\"#{imgsize}\" width=\"#{imgsize}\">"
  okimg = "<img src=\"glyphicons_198_ok-resize-invert.png\" height=\"#{imgsize}\" width=\"#{imgsize}\">"
  slider_change = ->
    # debounce slider events
    # http://unscriptable.com/2009/03/20/debouncing-javascript-methods/
    clearTimeout(timer) if timer?
    timer = setTimeout(passphrases, 100)
  submit_form = ->
    clearTimeout(timer) if timer?
    passphrases()
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
  
  $('#options_form').change(submit_form)
  $('#generate_btn').click(submit_form)
  $('#options_btn').click ->
    $('#options').slideToggle()
  
  # Min and max sliders should adjust sibling to prevent inverted ranges
  $('#min_length_slider').slider({
    value:4,
    min:1,
    max:20,
    slide: (event, ui) ->
      $('#min_length').val(ui.value)
      slider_change()
  })
  $('#min_length').val($('#min_length_slider').slider('value'))
  $('#max_length_slider').slider({
    value:10,
    min:1,
    max:20,
    slide: (event, ui) ->
      $('#max_length').val(ui.value)
      slider_change()
  })
  $('#max_length').val($('#max_length_slider').slider('value'))
  $('#min_rank_slider').slider({
    value:1,
    min:1,
    max:40000,
    slide: (event, ui) ->
      $('#min_rank').val(ui.value)
      slider_change()
  })
  $('#min_rank').val($('#min_rank_slider').slider('value'))
  $('#max_rank_slider').slider({
    value:10000,
    min:1,
    max:40000,
    slide: (event, ui) ->
      $('#max_rank').val(ui.value)
      slider_change()
  })
  $('#max_rank').val($('#max_rank_slider').slider('value'))
  $('#num_words_slider').slider({
    value:4,
    min:1,
    max:10,
    slide: (event, ui) ->
      $('#num_words').val(ui.value)
      slider_change()
  })
  $('#num_words').val($('#num_words_slider').slider('value'))
