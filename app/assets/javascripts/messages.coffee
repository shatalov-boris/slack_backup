do ($ = jQuery)->
  $(document).on "turbolinks:load",  ->
    highlightText($("#query-text").data("query")) if $("#query-text").text().length > 0

  highlightText = (query) ->
    $(".message-text").each (index, textElem) ->
      regExp = new RegExp(query, "giu")
      $(textElem).html($(textElem).html().replace(regExp, "<span class='highlight-text'>\$&</span>"))
