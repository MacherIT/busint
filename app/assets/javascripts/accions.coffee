
$(document).on "page:change", ->
    $("#tareas-list").on "click", ".accionToggleHecha", ->
        $.ajax({
            url: $(this).data("ref"),
            headers : {
                'Accept' : 'application/javascript',
            },            
            type: 'PUT',
            data: {
                id: $(this).data("id"),
                hecha: $(this).data("hecha")
            },
           success: ->
                return true
            error: ->
                return false
        })

#$(document).on "page:change", ->
#    $(".accionToggleHecha").click ->
#        $.ajax({
#            url: $(this).data("ref"),
#            headers : {
#                'Accept' : 'application/javascript',
#            },            
#            type: 'PUT',
#            data: {
#                id: $(this).data("id"),
#                hecha: $(this).data("hecha")
#            },
#           success: ->
#                return true
#            error: ->
#                return false
#        })
