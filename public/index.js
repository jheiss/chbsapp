$(document).ready(function() {
    const imgsize = "15";
    const clipimg = `<img src="glyphicons_029_notes_2-resize.png" height="${imgsize}" width="${imgsize}">`;
    const okimg = `<img src="glyphicons_198_ok-resize-invert.png" height="${imgsize}" width="${imgsize}">`;

    function copy_button_click(button) {
        $('#' + button.id).html(okimg);
        $('#' + button.id).addClass('btn-success');
        setTimeout(copy_button_unclick, 3000);
    }

    function copy_button_unclick() {
        $('.clip_button').html(clipimg);
        $('.clip_button').removeClass('btn-success');
    }

    function passphrases() {
        const formdata = $('#options_form').serialize();
        console.log(formdata);
        $.getJSON('passphrases', formdata, function(data) {
            const rows = [];
            const clips = [];
            // GET /passphrases returns an array of passphrases
            for (const [index, phrase] of data.entries()) {
                const button = `<button id="clip_button_${index}" class="clip_button btn btn-small" data-clipboard-text="${phrase}">${clipimg}</button>`;
                rows.push(`<tr><td><div class="passphrase">${phrase}</div></td><td class="td_button">${button}</td></tr>`);
            }
            $('table#passphrases > tbody').html(rows.join(''));
            const clipboard = new ClipboardJS('.clip_button');
            clipboard.on('success', function(e) {
                copy_button_click(e.trigger);
            })
        });
    }

    passphrases();

    $('#options_form').change(passphrases);
    $('#generate_btn').click(passphrases);
    $('#options_btn').click(function(data) {
        $('#options').slideToggle();
    })
});
