$(document).on "page:change", ->
    $(".comentario-form").hide()    
    $("ul#comentarios-list").on "dblclick", ".comentario", ->
        url = $(this).data("ref");
        id = $(this).data("comentario-id");
#        console.log('id: ' + id + ' - url: ' + url);
        $('#comentario-id-' + id + '-texto').hide();
        $('#comentario-id-' + id + '-form').show();

