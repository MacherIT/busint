$(document).on "page:change", ->
    $(".clickable-row").click ->
        window.document.location = $(this).data("href");
    $(".clickable-row").mouseenter ->
        $(this).toggleClass("back-verde-linkable");
    $(".clickable-row"). mouseleave ->
        $(this).toggleClass("back-verde-linkable");
